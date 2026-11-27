## What it does

`human-pr` drafts every pull request: a title, **Before / After / Why**, how it was verified (the exact commands and results), and risks and follow-ups. It shows the draft and waits for approval before `gh pr create`, and again before editing an open PR. The body never carries a tool footer.

## When to reach for it

Type `/human-pr`, or the agent reaches for it automatically whenever it opens or edits a PR. Finish the commits first with `human-commit`.

## Common questions

**Which branch does it target?**

The repo's default branch, never another feature branch, so no PR lands in a dead branch.

**What if a PR already exists for the branch?**

It updates that PR instead of opening a second one.

## It's working if

- Each PR body says what was run to verify it, and what was not.
- No PR body ends with "Generated with Claude Code".
