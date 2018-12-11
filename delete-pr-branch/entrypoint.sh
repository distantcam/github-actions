#!/bin/bash
set -e
set -o pipefail

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable."
  exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
  echo "Set the GITHUB_REPOSITORY env variable."
  exit 1
fi

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")
ref=$(jq --raw-output .pull_request.head.ref "$GITHUB_EVENT_PATH")

if [[ "$ref" == "master" ]]; then
  # Never delete the master branch.
  echo "Will not delete master branch for ${owner}/${repo}, exiting."
  exit 0
fi

echo "Deleting branch ref $ref for owner ${owner}/${repo}..."
curl -XDELETE -sSL \
  -H "${AUTH_HEADER}" \
  -H "${API_HEADER}" \
  "${URI}/repos/${owner}/${repo}/git/refs/heads/${ref}"

echo "Branch delete success!"