## What it does

`human-commit` drafts every commit as a plain **Before / After / Why** summary plus an imperative message, shows it, and waits. Nothing is committed until the operator approves the draft, and nothing is pushed unless asked.

## When to reach for it

Type `/human-commit`, or the agent reaches for it automatically whenever it is about to commit. For the PR that carries the commits, use `human-pr`.

## Common questions

**Does it add a "Co-Authored-By" trailer?**

Yes, that trailer is fine. It never adds a "Generated with Claude Code" line or any other tool footer. If the agent platform asks for one, `override-warning` makes the agent say so.

**What if the diff mixes unrelated changes?**

It proposes separate commits by topic first, and never commits `.env` or credentials.

## It's working if

- Every commit you see was shown to you first as Before / After / Why.
- No commit carries a tool footer.
