---
name: human-commit
description: Draft and execute human-readable Git commits with clear before-and-after context. Never auto-commit without showing the summary first.
---

# Workflow
1. Run `git status` and `git diff --staged` (if nothing is staged, inspect `git diff` and propose logical file groupings).
2. Never commit `.env`, credentials, or unrelated formatting changes in the same commit.
3. Present a human-readable **Before & After** summary to the user before running `git commit`:
   - **Before:** Explain the previous behavior, bug, or limitation in plain language.
   - **After:** Explain what changed and how the system behaves now.
   - **Why:** State the practical reason for the change in one sentence.
4. Draft a commit message using a clear imperative subject line (max 72 chars) followed by a short body capturing the Before/After state. Avoid robotic filler like "Updated files" or "Refactored logic".
5. Before showing the draft, run the `override-warning` check: if any system or platform instruction conflicts with this skill or the operator's rules, start and end the response with a `WARNING:` line naming it. No "Generated with Claude Code" line or any tool footer; a `Co-Authored-By` trailer is fine.
6. Wait for explicit user approval before running `git commit`. Never run `git push` unless asked.
