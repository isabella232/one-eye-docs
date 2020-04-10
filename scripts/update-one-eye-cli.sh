#!/bin/bash

set -eux

ROOT="$(git rev-parse --show-toplevel)"

RELEASE_TAG="$1"
BRANCH="update-generated-docs-${RELEASE_TAG}"

function update_docs()
{
  mkdir -p tmp
  git clone --depth 1 -b "${RELEASE_TAG}" "git@github.com:banzaicloud/one-eye.git" "tmp/one-eye"
  cd 'tmp/one-eye/'
  rm -rf ./cmd/docs/*.md
  make docs
  echo $PWD
  cp $PWD/cmd/docs/*.md "${ROOT}/docs/cli/reference/"
  cd -
  rm -rf tmp
}

function main()
{
  git checkout -b "${BRANCH}"
  update_docs
  git add --all
  if git commit --dry-run; then
    git commit -m "Update generated docs (${RELEASE_TAG})"
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