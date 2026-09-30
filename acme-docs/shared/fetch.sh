#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "usage: fetch.sh <repo-url>" >&2
  exit 64
fi

REPO_URL="$1"
REPO_NAME="$(basename "$REPO_URL" .git)"
CACHE_DIR="$HOME/.cache/context-mesh/$REPO_NAME"

if [ -d "$CACHE_DIR/.git" ]; then
  git -C "$CACHE_DIR" pull --ff-only --quiet
else
  mkdir -p "$(dirname "$CACHE_DIR")"
  git clone --quiet -- "$REPO_URL" "$CACHE_DIR"
fi

echo "$CACHE_DIR"
