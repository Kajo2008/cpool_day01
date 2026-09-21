#!/bin/bash
# push_that.sh — add all files, commit with the given message, then push
# Usage: ./push_that.sh "my commit message"

if [ -z "$1" ]; then
    echo "Usage: $0 \"commit message\"" >&2
    exit 84
fi

git add .
git commit -m "$1"
# Bypass simple obstacles: pull --rebase if remote has new commits, then push
git pull --rebase origin "${CURRENT_BRANCH:-$(git rev-parse --abbrev-ref HEAD)}" 2>/dev/null || true
git push origin "$(git rev-parse --abbrev-ref HEAD)"
