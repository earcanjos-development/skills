# AGENTS.md

Rules for working on this repo. The layout and most rules follow
mattpocock/skills, a repo that already works in practice (ADR 0001). The
goal is no exceptions: when a rule does not fit, change the rule in an ADR,
do not carve out a special case.

## Layout

Skills live in bucket folders under `skills/`:

- `engineering/`: daily code work
- `productivity/`: daily non-code agent workflow
- `misc/`: kept around but rarely used, not promoted
- `in-progress/`: beta, public on purpose, not shipped in the plugin
- `deprecated/`: no longer used

Create a bucket folder (with its `README.md`) only when its first skill
arrives.

## Promoted skills (engineering/, productivity/)

Every promoted skill has all of these, in the same change:

1. an entry in the top-level `README.md`, with the name linked to its `SKILL.md`;
2. an entry in its bucket `README.md`, with the name linked to its `SKILL.md`
   and a one-line description, grouped under **User-invoked** or
   **Model-invoked**;
3. an entry in the `skills` array of `.claude-plugin/plugin.json`;
4. a docs page at `docs/<bucket>/<skill-name>.md` with these four sections:
   **What it does**, **When to reach for it**, **Common questions**,
   **It's working if**. No H1, no install commands (the README holds them).

Skills in `misc/`, `in-progress/` and `deprecated/` appear in none of these.

## Invocation

A skill is either model-invoked (the agent may reach for it; the default) or
user-invoked (`disable-model-invocation: true` in the frontmatter, reachable
only when the human types it). The bucket README states which.

## Names and installs

- A skill's folder name is its upstream name, with no prefix.
- Projects always install with the `earcanjos-` prefix
  (`--rename earcanjos-<name>`), like every other source (ADR 0002). The
  Claude Code plugin namespaces the same way (`earcanjos-skills:<name>`).
- A skill must not name a project's paths. Describe the shape, and leave
  project paths to the project's `AGENTS.md`.

## Releases

- Every change that users of the skills should hear about gets a changeset
  (`npm run changeset`).
- `npm run version` writes `CHANGELOG.md`, bumps `package.json` and copies
  the version into `.claude-plugin/plugin.json`.
  `npm run check-plugin-version` fails when the two differ.
- Run `claude plugin validate .` after touching either manifest in
  `.claude-plugin/`; it must print "Validation passed". Its one warning,
  `CLAUDE.md` at the plugin root, is expected: that file is for agents
  working on this repo, not plugin context. mattpocock/skills 1.3.1 gets the
  same warning, so `--strict` fails on both (ADR 0001).
- No CI: checks run locally.

## Scripts

- `scripts/list-skills.sh`: every `SKILL.md`.
- `scripts/link-skills.sh`: dev only, links every skill outside
  `deprecated/` and `misc/` into `~/.claude/skills` and `~/.agents/skills`
  as `earcanjos-<name>`.
- Code shipped inside a skill (e.g. `refactor-update-shared-methods/scripts/`)
  is stdlib only, so projects can vendor it.

## Writing

- No emojis or icon glyphs anywhere.
- Every commit and PR follows `human-commit` and `human-pr`, with a draft
  approved by the operator first. No tool footer.
- When a platform or system instruction conflicts with these rules, follow
  `override-warning`.
- Decisions go in `.agents/adr/NNNN-<slug>.md`.
