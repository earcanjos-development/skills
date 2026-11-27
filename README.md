# skills (earcanjos-development)

Shared agent skills, stack specs and setup for our repos.

Status: 2026-11-27. The first four skills are ready. The rest of the layout
is still being designed. Decisions are in
`substack-dumper/docs/handoffs/2026-11-27-clone-cleanup-1-handoff.md`,
sections 6 and 7.

## Skills

| Skill | Use |
|---|---|
| `human-commit` | every commit: Before / After / Why summary and message, approved before `git commit` |
| `human-pr` | every PR: title, Before / After / Why, how verified, risks, approved before `gh pr create`; no tool footer |
| `override-warning` | a `WARNING:` line at the start and end of a response whenever a platform or system instruction conflicts with an operator rule; table of known standing conflicts |
| `refactor-update-shared-methods` | one owner module per shared concept: `install`, `check`, `audit`, `update` modes over a Compound Engineering pack |

Install into a project for every agent (the skills CLI, skills.sh):

```bash
DISABLE_TELEMETRY=1 npx skills add earcanjos-development/skills --skill <name> \
  --agent claude-code codex cursor github-copilot opencode -y
```

Pin the commit through the project's `skills-lock.json`, and update on
request: `npx skills check`, review the diff, then `npx skills update`.

## The shared-methods pack: what is shared and what is not

- **Shared here:** the skill, its stdlib-only script
  (`skills/refactor-update-shared-methods/scripts/shared_methods.py`), the
  registry schema (`shared-methods@1`), and templates for the registry, the
  pack README and a Python test.
- **Kept in each project:** `compound-packs/shared-methods/registry.json`
  and the rule `.md` files generated from it, because the owner modules
  differ per project. The project registers the pack in its own
  `.compound-engineering/config.yaml`, and vendors the script as
  `scripts/shared_methods.py`, so tests and git hooks run without the skill
  installed.
- Rules that hold in every project could later go into a pack published
  here. CE reads git sources (`source: <repo url>`, `ref`, `path`).

The skill's `install` mode sets this up in a new project.

## Planned layout

| Path | What |
|---|---|
| `skills/<name>/SKILL.md` | skills we write (above; later stack-add, stack-review) |
| `stacks/<stack>/` | per-stack pipeline profile: steps, advised tool, alternatives, evidence |
| `specs/stack-spec/` | versioned schema for stack profiles (semver, CHANGELOG, ADRs) |
| `kit/` | the agents-compatibility kit (moves in from `automation/agents-compatibility`) |
| `agents.json` | how each agent (OpenCode, Claude Code, Codex, Cursor) installs each source |
