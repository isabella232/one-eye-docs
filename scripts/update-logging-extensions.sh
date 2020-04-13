#!/bin/bash

set -eux

ROOT="$(git rev-parse --show-toplevel)"
PROJECT=logging-extensions
RELEASE_TAG="$1"
BRANCH="update-generated-docs-${PROJECT}-${RELEASE_TAG}"

function cleanup {
  rm -rf ${ROOT}/tmp
}
trap cleanup EXIT

function update_docs()
{
  mkdir -p ${ROOT}/tmp
  git clone --depth 1 -b "${RELEASE_TAG}" "git@github.com:banzaicloud/${PROJECT}.git" "${ROOT}/tmp/${PROJECT}"
  cd "${ROOT}/tmp/${PROJECT}/"
  rm -rf ./cmd/docs/*.md
  make docs
  echo $PWD
  mkdir -p "${ROOT}/docs/${PROJECT}/reference/"
  cp $PWD/docs/types/*.md "${ROOT}/docs/${PROJECT}/reference/"
  cd -
  rm -rf ${ROOT}/tmp
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
    echo "Commit has changed."
  else
    echo "Nothing has changed."
    circleci-agent step halt
    exit 0
  fi
}

main