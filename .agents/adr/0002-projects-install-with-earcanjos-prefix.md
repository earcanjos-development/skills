# Projects install our skills with the earcanjos- prefix

Date: 2026-11-27. Decided by: the operator (option b, "avoid exceptions").

## Context

Consumer projects (e.g. substack-dumper) name every skill installed from
GitHub `<prefix>-<upstream name>`, from `config.skillPrefixes` in their
`package.json`. Before this repo existed, substack-dumper kept
`human-commit` and `human-pr` as local skills with no prefix: an exception
to that rule.

## Decision

Projects install from `earcanjos-development/skills` like any other source:
`--rename earcanjos-<name>`, with `"earcanjos-development/skills": "earcanjos"`
in `config.skillPrefixes`. No local copies and no prefix exception. Folder
names in this repo stay unprefixed (the upstream name), as in every other
source. The Claude Code plugin namespaces them as `earcanjos-skills:<name>`.

## Consequences

- A project's `AGENTS.md` names a skill by its installed name, e.g.
  `earcanjos-human-pr`. Skills in this repo name each other by upstream
  name, as mattpocock/skills does.
- A skill changes here first, then reaches a project through a lock bump
  the operator reviews.
