#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "usage: fetch.sh <cache-name> <repo-url>" >&2
  exit 64
fi

CACHE_NAME="$1"
REPO_URL="$2"
CACHE_DIR="$HOME/.cache/context-mesh/$CACHE_NAME"

if [ -d "$CACHE_DIR/.git" ]; then
  git -C "$CACHE_DIR" pull --ff-only --quiet
else
  mkdir -p "$(dirname "$CACHE_DIR")"
  git clone --quiet "$REPO_URL" "$CACHE_DIR"
fi

echo "$CACHE_DIR"
