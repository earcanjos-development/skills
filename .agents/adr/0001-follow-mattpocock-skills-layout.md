# Follow the mattpocock/skills repo layout and rules

Date: 2026-11-27. Decided by: the operator.

## Context

We needed a layout for our shared skills. mattpocock/skills (version 1.3.1,
MIT) is used daily by many people and is installed on every agent we use
(Claude Code plugin, Codex, OpenCode through skills.sh). The operator asked
for our repos to use patterns that already work, and to avoid exceptions.

## Decision

Copy its structure and rules, adapted to our scale:

- bucket folders under `skills/` (`engineering/`, `productivity/`, and
  `misc/`, `in-progress/`, `deprecated/` when needed), each with a `README.md`;
- `.claude-plugin/plugin.json` listing exactly the promoted skills, and
  `.claude-plugin/marketplace.json` so the repo is its own marketplace;
- one docs page per promoted skill with four sections;
- changesets for versions, with `scripts/sync-plugin-version.mjs` keeping
  `plugin.json` in step with `package.json`;
- `scripts/link-skills.sh` and `scripts/list-skills.sh`;
- ADRs in `.agents/adr/`.

Two scripts are adapted from that repo and say so in their header.

## Not taken (for now)

- The `ask-<name>` router skill: four skills do not need a router.
- The published docs site and the `.agents/writing-docs.md` guide: the four
  sections are stated in `AGENTS.md`.
- The no-em-dash rule, GitHub workflows (we run no CI), issue triage labels,
  `SCOPE.md` and `.out-of-scope/`.

Validation: `claude plugin validate .` passes with one warning (`CLAUDE.md`
at the plugin root is not plugin context). mattpocock/skills 1.3.1 gets the
same warning with Claude Code 2.1.332, so we use the plain check, not
`--strict`. The plugin-directory check also wants a LICENSE before any
submission.

Revisit when the repo has more than about ten skills or outside users.
