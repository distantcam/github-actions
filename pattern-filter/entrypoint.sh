#!/bin/sh

set -e

if [ -z "$GITHUB_EVENT_PATH" ]; then
  echo "\$GITHUB_EVENT_PATH" not found
  exit 1
fi

pattern="$1"
expected="$2"
actual=$(jq -r "$pattern" "$GITHUB_EVENT_PATH")

echo "DEBUG -> expected: $expected actual: $actual"

if [[ "$actual" != "$expected" ]]; then
  exit 78
fi