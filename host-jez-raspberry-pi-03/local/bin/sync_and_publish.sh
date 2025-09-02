#!/usr/bin/env bash

set -euo pipefail

cd "/home/jez/github/recipes"

if ! output="$(rsync --archive --delete --itemize-changes \
  "/home/jez/Dropbox/Apps/remotely-save/main/recipes/" \
  _recipes)"; then
  echo "$output"
  exit 1
fi

if [ "$output" = "" ]; then
  exit
fi

echo "Detected changes, publishing site..."

git add _recipes

if ! git diff --staged --quiet; then
  git commit -m "Updated site - '$(date +'%Y-%m-%d %T %Z')'"
  git push
fi
