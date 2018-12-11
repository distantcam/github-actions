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

action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")
assignee=$(jq --raw-output .pull_request.assignee "$GITHUB_EVENT_PATH")

echo "DEBUG -> action: $action assignee: $assignee"

# Assign the user who opened the PR
user=$(jq --raw-output .pull_request.user.login "$GITHUB_EVENT_PATH")
owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")
number=$(jq --raw-output .number "$GITHUB_EVENT_PATH")

echo "Assigning PR to user $user..."
curl -X POST -sSL \
  -H "${AUTH_HEADER}" \
  -H "${API_HEADER}" \
  -H "Content-Type: application/json" \
  -d "{\"assignees\":[\"${user}\"]}" \
  "${URI}/repos/${owner}/${repo}/issues/${number}/assignees"

echo "Assigned user success!"