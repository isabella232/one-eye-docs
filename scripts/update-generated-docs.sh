#!/bin/bash

set -eux

ROOT="$(git rev-parse --show-toplevel)"
PROJECT="$1"
RELEASE_TAG="$2"
BUILD_DIR="$3"
BRANCH="${PROJECT}-${RELEASE_TAG}-$(date '+%F-%H-%M')"

function cleanup {
  rm -rf ${ROOT}/tmp
}
trap cleanup EXIT

function update_docs()
{
  checkout_source
  make docs

  case "${PROJECT}" in
    one-eye)
      copy_docs 'cli/reference/' 'docs/cli/reference/'
      copy_docs 'crds/' 'docs/crds/'
      ;;
    logging-extensions)
      copy_docs '.' 'docs/logging-extensions/reference/'
      ;;
    *)
      echo 'Unknown project'
      exit 1
  esac

  cd ${ROOT}
  rm -rf tmp
}

function checkout_source()
{
  mkdir -p ${ROOT}/tmp
  git clone --depth 1 -b "${RELEASE_TAG}" "https://github.com/banzaicloud/${PROJECT}.git" "${ROOT}/tmp/${PROJECT}"
  cd "${ROOT}/tmp/${PROJECT}/"
}

function copy_docs()
{
  local source_dir="$1"
  local target_dir="$2"

  mkdir -p "${ROOT}/${target_dir}"
  find "${ROOT}/${target_dir}" -type f -not -name '_index.md' -delete
  find "${ROOT}/tmp/${PROJECT}/${BUILD_DIR}/${source_dir}" -name '*.md' -exec cp {} "${ROOT}/${target_dir}" \;
}

function create_pr()
{
  local title="$1"
  local body="$2"
  local branch="$3"

  curl \
    -sS \
    -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -d "{
      \"title\": \"${title}\",
      \"head\": \"${branch}\",
      \"base\": \"master\",
      \"body\": \"${body}\",
      \"maintainer_can_modify\": true
    }" 'https://api.github.com/repos/banzaicloud/one-eye-docs/pulls'
}

function main()
{
  git checkout -b "${BRANCH}"
  update_docs
  git add --all
  if git commit --dry-run; then
    git commit -m "Update generated docs (${PROJECT}-${RELEASE_TAG})"
    git push origin "${BRANCH}"
    create_pr "Update ${PROJECT} generated docs" "Update ${PROJECT} generated docs to ${RELEASE_TAG}" "${BRANCH}"
  else
    echo "Nothing has changed."
    circleci-agent step halt
    exit 0
  fi
}

main
