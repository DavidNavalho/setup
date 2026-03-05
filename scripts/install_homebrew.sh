#!/usr/bin/env bash
set -euo pipefail

# Idempotent Homebrew installer for macOS.
# Safe to run multiple times.

if command -v brew >/dev/null 2>&1; then
  echo "Homebrew already installed: $(command -v brew)"
  exit 0
fi

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script is intended for macOS (Darwin)." >&2
  exit 1
fi

# Xcode CLT is required for Homebrew.
if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools…"
  xcode-select --install || true
  echo "Re-run this script after Command Line Tools finish installing."
  exit 0
fi

echo "Installing Homebrew…"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Homebrew installed. You may need to add brew to your PATH (the installer prints instructions)."
