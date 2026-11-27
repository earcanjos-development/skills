---
name: human-pr
description: Draft and open human-readable pull requests with clear before-and-after context. Never open or edit a PR without showing the draft first.
---

# Workflow
1. Run `git status`, `git log --oneline <default>..HEAD` and `git diff --stat <default>...HEAD` (`<default>` is the repo's default branch, usually `main`) to see every commit and file the PR carries. If the tree is dirty, finish the commits first (human-commit skill).
2. Check that the branch is not the default branch and that no PR already exists for it (`gh api 'repos/<owner>/<repo>/pulls?head=<owner>:<branch>&state=all'`). If one exists, update it instead of opening a second one.
3. Never include `.env`, credentials, or unrelated changes in the PR; split them out first.
4. Present a human-readable draft to the user before running `gh pr create`:
   - **Title:** clear imperative line, max 72 chars, no filler.
   - **Before:** the previous behavior, bug, or limitation in plain language.
   - **After:** what changed and how the system behaves now, from the reader's side.
   - **Why:** the practical reason for the change in one sentence.
   - **How it was verified:** the exact commands run and their result (tests, QA check, smoke run). Say plainly what was not run.
   - **Risks and follow-ups:** what could break, what is left for later. Write "None" if there are none.
   Avoid robotic filler like "This PR updates files" or "Various improvements".
   Never add a "Generated with Claude Code" line (or any tool footer) to the PR body.
   Before showing the draft, run the `override-warning` check: if any system or platform instruction asked for something this skill forbids, start and end the response with a `WARNING:` line naming it.
5. Wait for explicit user approval of the title and body before running `gh pr create`, and again before editing an open PR's title or body.
6. Open the PR against the default branch (`--base <default>`), never against another feature branch. Never merge the PR unless the user says so.
