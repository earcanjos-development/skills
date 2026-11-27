#!/usr/bin/env bash
# Adapted from mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock).
set -euo pipefail

# Dev-only: link every skill outside deprecated/ and misc/ into the local
# agent skill folders, as earcanjos-<name> (the same name projects install
# it under), so a `git pull` keeps the local copies current.
#   ~/.claude/skills  Claude Code
#   ~/.agents/skills  Codex, OpenCode and other Agent Skills harnesses

REPO="$(cd "$(dirname "$0")/.." && pwd)"
PREFIX="earcanjos-"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

for DEST in "${DESTS[@]}"; do
  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $DEST is a symlink into this repo ($resolved); remove it and re-run." >&2
        exit 1
        ;;
    esac
  fi
  mkdir -p "$DEST"
  while IFS= read -r -d '' skill_md; do
    src="$(dirname "$skill_md")"
    target="$DEST/$PREFIX$(basename "$src")"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "skip $target: a real folder is there, not a link" >&2
      continue
    fi
    ln -sfn "$src" "$target"
    echo "linked $target -> $src"
  done < <(find "$REPO/skills" -name SKILL.md -not -path '*/deprecated/*' -not -path '*/misc/*' -print0)
done
