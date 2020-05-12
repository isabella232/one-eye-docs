#!/bin/bash

set -eux

ROOT="$(git rev-parse --show-toplevel)"
PROJECT="$1"
RELEASE_TAG="$2"
BUILD_DIR="$3"
TARGET_DIR="$4"
BRANCH="update-generated-docs-${PROJECT}-${RELEASE_TAG}"

function cleanup {
  rm -rf ${ROOT}/tmp
}
trap cleanup EXIT

function update_docs()
{
  mkdir -p ${ROOT}/tmp
  git clone --depth 1 -b "${RELEASE_TAG}" "https://github.com/banzaicloud/${PROJECT}.git" "${ROOT}/tmp/${PROJECT}"
  cd "${ROOT}/tmp/${PROJECT}/"
  make docs
  mkdir -p "${ROOT}/${TARGET_DIR}"
  find "${ROOT}/${TARGET_DIR}" -type f -not -name '_index.md' -delete
  find "${ROOT}/tmp/${PROJECT}/${BUILD_DIR}" -name '*.md' -exec cp {} "${ROOT}/${TARGET_DIR}" \;
  cd ${ROOT}
  rm -rf tmp
}

function main()
{
  git checkout -b "${BRANCH}"
  update_docs
  git add --all
  if git commit --dry-run; then
    git commit -m "Update generated docs (${PROJECT}-${RELEASE_TAG})"
    git checkout master
    git merge "${BRANCH}"
    git push origin master
  else
    echo "Nothing has changed."
    circleci-agent step halt
    exit 0
  fi
}

main
