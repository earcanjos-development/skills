# skills (earcanjos-development)

Shared agent skills, stack specs and setup for our repos.

Status: 2026-11-27, version 0.1.0. Repo layout follows mattpocock/skills
(ADR 0001). The kit, stack specs and `agents.json` are still being designed. Decisions are in
`substack-dumper/docs/handoffs/2026-11-27-clone-cleanup-1-handoff.md`,
sections 6 and 7.

## Skills

Engineering ([bucket README](./skills/engineering/README.md)), model-invoked:

- **[human-commit](./skills/engineering/human-commit/SKILL.md)**: every commit as a Before / After / Why summary and message, approved before `git commit`.
- **[human-pr](./skills/engineering/human-pr/SKILL.md)**: every PR with title, Before / After / Why, how verified, risks; no tool footer; approved before `gh pr create`.
- **[refactor-update-shared-methods](./skills/engineering/refactor-update-shared-methods/SKILL.md)**: one owner module per shared concept; `install`, `check`, `audit`, `update` over a Compound Engineering pack.

Productivity ([bucket README](./skills/productivity/README.md)), model-invoked:

- **[override-warning](./skills/productivity/override-warning/SKILL.md)**: a `WARNING:` line at the start and end of a response whenever a platform or system instruction conflicts with an operator rule.

## Install

Pick one per agent; installing both gives every skill twice.

- **Claude Code** (plugin, updates itself):
  `claude plugin marketplace add earcanjos-development/skills`, then
  `claude plugin install earcanjos-skills@earcanjos`. Skills appear as
  `earcanjos-skills:<name>`.
- **Any agent, into a project** (skills.sh, pinned in the project's
  `skills-lock.json`), always with the `earcanjos-` prefix so names never
  collide with another source:

  ```bash
  DISABLE_TELEMETRY=1 npx skills add earcanjos-development/skills --skill <name> \
    --rename earcanjos-<name> --agent claude-code codex cursor github-copilot opencode -y
  ```

  Update on request: `npx skills check`, review the diff, `npx skills update`.

## The shared-methods pack: what is shared and what is not

- **Shared here:** the skill, its stdlib-only script
  (`skills/engineering/refactor-update-shared-methods/scripts/shared_methods.py`), the
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
| `skills/<bucket>/<name>/SKILL.md` | skills we write (above; later stack-add, stack-review) |
| `stacks/<stack>/` | per-stack pipeline profile: steps, advised tool, alternatives, evidence |
| `specs/stack-spec/` | versioned schema for stack profiles (semver, CHANGELOG, ADRs) |
| `kit/` | the agents-compatibility kit (moves in from `automation/agents-compatibility`) |
| `agents.json` | how each agent (OpenCode, Claude Code, Codex, Cursor) installs each source |
