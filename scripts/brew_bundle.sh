#!/usr/bin/env bash
set -euo pipefail

# Run Brewfile bundle in an idempotent way.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREWFILE="$ROOT_DIR/Brewfile"

if [[ ! -f "$BREWFILE" ]]; then
  echo "Brewfile not found at: $BREWFILE" >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Run: $ROOT_DIR/scripts/install_homebrew.sh" >&2
  exit 1
fi

echo "Running: brew bundle --file $BREWFILE"
brew bundle --file "$BREWFILE"
