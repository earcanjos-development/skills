# skills (earcanjos-development)

Shared agent skills, stack specs and setup for our repos.

Status: being designed (2026-11-27). Decisions so far are in
`substack-dumper/docs/handoffs/2026-11-27-clone-cleanup-1-handoff.md`,
sections 6 and 7. Nothing here is ready to install yet.

Planned layout:

| Path | What |
|---|---|
| `skills/<name>/SKILL.md` | skills we write (human-commit, human-pr, refactor-update-shared-methods, stack-add, stack-review) |
| `stacks/<stack>/` | per-stack pipeline profile: steps, advised tool, alternatives, evidence |
| `specs/stack-spec/` | versioned schema for stack profiles (semver, CHANGELOG, ADRs) |
| `agents.json` | how each agent (OpenCode, Claude Code, Codex, Cursor) installs each source |
