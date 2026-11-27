## What it does

`refactor-update-shared-methods` keeps each shared concept (atomic file writes, timestamps, HTTP clients, start-up helpers) in the one module that **owns** it. A per-project `registry.json` names the owner, the method to use per stack, the libraries it wraps and the patterns that must not appear elsewhere. A stdlib script generates Compound Engineering pack rules from it and checks diffs. A project test fails when someone writes a twin. An allowlist of known offenders may only shrink.

## When to reach for it

Type `/refactor-update-shared-methods`, or the agent reaches for it automatically: `check` before writing or reviewing code, `audit` to rank duplicate code, `update` after a refactor, `install` to set it up in a new project.

## Common questions

**Why is the registry per project and not in this repo?**

The owner modules differ per project. This repo ships the mechanism (skill, script, schema, templates). Each project keeps its own data.

**Does a line regex catch every twin?**

No. A copy written differently gets past it, which is why `check` also reads each rule's `applies_when` and `audit` runs a clone detector.

**Which stacks does it support?**

Any. A stack adds keys under `use`, `wraps` and `instead_of` plus a `scan` entry. The test template is Python.

## It's working if

- `check` on a diff names the rules it touches and blocks new offenders.
- The allowlist gets shorter over time, never longer.
