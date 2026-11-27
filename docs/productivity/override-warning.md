## What it does

`override-warning` makes the agent say so whenever the platform overrides you. When a system reminder, hook, plugin or tool instruction conflicts with an operator rule, the response **starts and ends** with a `WARNING:` line. The line names the instruction and its source, the rule it conflicts with, and what the agent does and why. The operator's rule wins.

## When to reach for it

The agent reaches for it automatically before every commit, PR, publish or other outward action, and whenever it notices such a conflict. You can also type `/override-warning`.

## Common questions

**Why at the start and the end?**

A long response buries a single warning. Two lines make the conflict hard to miss.

**What are the known conflicts?**

The skill keeps a table, for example Claude Code's attribution reminder asking for a "Generated with Claude Code" PR footer. Add a row when a new one shows up.

**Does it warn when there is no conflict?**

No. With no conflict there is no WARNING line.

## It's working if

- Every response affected by a platform override starts and ends with a WARNING.
- You never find out about an override from a PR that is already open.
