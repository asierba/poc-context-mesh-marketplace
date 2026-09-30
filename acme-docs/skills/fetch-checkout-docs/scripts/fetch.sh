#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/asierba/poc-context-mesh-checkout.git"
CACHE_DIR="$HOME/.cache/context-mesh/checkout"

if [ -d "$CACHE_DIR/.git" ]; then
  git -C "$CACHE_DIR" pull --ff-only --quiet
else
  mkdir -p "$(dirname "$CACHE_DIR")"
  git clone --quiet "$REPO_URL" "$CACHE_DIR"
fi

echo "$CACHE_DIR"
