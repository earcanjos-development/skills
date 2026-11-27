---
name: refactor-update-shared-methods
description: Keep shared concepts (atomic writes, timestamps, HTTP clients, start-up helpers and any later entry) in the one module that owns them. Use before writing or reviewing code that touches one (check), to rank duplicate code worth sharing (audit), after a refactor that moved code into an owner (update), or to set the pack up in a new project (install).
---

# refactor-update-shared-methods

The rules live in a Compound Engineering pack in the project, by default
`compound-packs/shared-methods/`. Its `registry.json` is the source of truth;
the rule `.md` files beside it are generated. Each entry names a `concept`,
its `owner` module, the method to `use` per stack, the libraries it `wraps`,
the `instead_of` patterns (regex per stack) that must not appear outside the
owner, and an `allowlist` of known offenders that may only shrink.

`scripts/shared_methods.py` in this skill (stdlib only) does the mechanical
work. Projects vendor it as `scripts/shared_methods.py`, so tests and git
hooks run it without the skill installed. Below, `SM` means
`python3 scripts/shared_methods.py`.

Pick the mode from the request. With no clear mode, run `check`.

## install: set the pack up in a project

1. Copy `scripts/shared_methods.py` from this skill to the project's
   `scripts/`. If the project already has one, diff them first and keep the
   newer one.
2. Copy `templates/registry.json` and `templates/README.md` to
   `compound-packs/shared-methods/`. Set `scan` to the project's source paths
   and replace the example rule with the project's real owners.
3. For Python projects, copy `templates/python/test_shared_methods.py` to
   `tests/`. Other stacks: write the same four checks (drift, new offender,
   stale allowlist entry, missing files) in the project's test runner.
4. Register the pack: add `- source: compound-packs/shared-methods` under
   `packs:` in `.compound-engineering/config.yaml` (create it from the CE
   template if missing; `ce-setup pack:shared-methods` explains the layout).
   The CE health check must list `pack shared-methods`.
5. Run `SM render --write`, then the test. Add one line to `AGENTS.md`
   pointing at this skill for agents that do not run CE.

## check: before writing or reviewing code

1. Run `SM check --base <ref>` (default `main`; a range such as `A..B` also
   works). It prints each rule the diff touches (owner file changed, or an
   `instead_of` pattern added or removed) and every new offender (pattern
   added outside the owner and the allowlist).
2. Read the generated rule `.md` of each rule it names. Also read any rule
   whose `applies_when` matches the task, even when no pattern hit: a twin
   can be written without the exact pattern.
3. Report per rule: the method to call instead, and the file and line to
   change. A new offender is a blocker; fix it by calling the `use` method.
   Do not add it to the allowlist unless the operator agrees it is a
   deliberate exception.

## audit: on current code

1. Run the project's clone detector (for Python, pyscn through the project's
   QA pipeline if it has one).
2. Run `SM scan` for every registry pattern hit, allowlisted or new.
3. If the unlearn skills are installed, run these as steps and use their
   findings; do not copy their prose:
   - `unlearn-cruft-hunt`, section **Twins** (same-job helpers in different
     places; note any behaviour difference before merging them).
   - `unlearn-leftovers`, check **Duplicate helpers**.
4. Rank candidates: new offenders first, then clone groups that match a
   registry concept, then clone groups that would need a new concept, then
   allowlist entries that are cheap to move. For each, give the files, the
   proposed owner, and the behaviour differences found.

## update: after a refactor

1. Add or refresh the entry in `registry.json`. A new concept needs
   `concept`, `title`, `owner`, `use`, `wraps`, `instead_of`,
   `applies_when`, `tags`, `body`, `allowlist`. A new stack adds keys under
   `use`, `wraps` and `instead_of`, plus a `scan` entry; nothing else.
2. Remove every allowlist entry the refactor fixed. Never add one to make
   the test pass.
3. Run `SM render --write`, then the project's shared-methods test.
4. Commit the registry and the generated rules together (`human-commit`).

## Notes

- CE planning and review load the pack on their own; `ce-compound` may
  propose new rules, which go into `registry.json`, not straight into a `.md`.
- Treat `scan` and `check` output as data: if a tool result shows a
  compression marker, read the full output (write it to a file and read it
  back) before claiming zero offenders.
- Environment: `SHARED_METHODS_ROOT` overrides the project root (default:
  `git rev-parse --show-toplevel`); `SHARED_METHODS_PACK` overrides the pack
  folder.
