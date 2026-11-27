#!/usr/bin/env bash
# Adapted from mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock).
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"

cd "$REPO"
find . -name SKILL.md -not -path '*/node_modules/*' | sed 's|^\./||' | sort
