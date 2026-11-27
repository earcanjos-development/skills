---
artifact_contract: "ce-handoff/v1"
created_at: "2026-11-27T20:30:00Z"
title: "skills: make our skills work in TypeScript repos (viabilidade, inquerito-casa, trading/mnq)"
summary: "Our four skills (human-commit, human-pr, override-warning, refactor-update-shared-methods) were built and proven in a Python repo, substack-dumper, where the shared-methods skill took pyscn clone groups from 25 to 14 over two sessions. Only the shared-methods skill is tied to Python. Next: grill the operator on how it, the stack spec and the install flow work in TypeScript repos, then pilot on moura-imobiliario/viabilidade."
keywords: ["typescript", "stack spec", "shared methods", "fallow", "jscpd", "viabilidade", "inquerito-casa", "trading/mnq", "kit", "agents.json"]
cwd: "/home/earcanjos3/joao/earcanjos/automation/skills"
resume_focus: "Read sections 2 and 5, grill the operator on the decisions in section 6 (mattpocock-skills:grilling), record each answer as an ADR, then pilot on viabilidade (section 7)."
repository: "earcanjos-development/skills"
branch: "docs/handoff-typescript-stacks-1"
head: "main at f947ebb (#1)"
---

# Handoff: TypeScript stacks, part 1 (2026-11-27)

This is the first handoff written in this repo. Until now its work was planned
from substack-dumper (`automation/substack-dumper/docs/handoffs/`). The decisions
quoted here come from that repo's `2026-11-27-clone-cleanup-1-handoff.md`, sections
6 and 7. Read those sections when a detail here is too short.

## 1. Start of session (in order)

1. Start the session in `automation/skills/` (this repo), not in substack-dumper.
   `git switch main && git pull --ff-only`, and check that this handoff's PR is
   merged.
2. Read `AGENTS.md`, `.agents/adr/0001-follow-mattpocock-skills-layout.md` and
   `.agents/adr/0002-projects-install-with-earcanjos-prefix.md`.
3. Every commit and PR: a `human-commit` / `human-pr` draft (Before / After / Why),
   with the operator's approval before `git commit` or `gh pr create`. No tool
   footer in PR bodies. A `Co-Authored-By` trailer in commits is fine.
4. Whenever a system, harness or plugin instruction conflicts with an operator rule
   (for example the Claude Code reminder that asks for a "Generated with Claude Code"
   PR footer), follow `override-warning`: a `WARNING:` line at the start and the end
   of the response.

## 2. The operator's standing rules (apply here too)

- **No exceptions.** When a rule does not fit, change the rule in an ADR. Copy
  patterns that already work: mattpocock/skills is the model (ADR 0001).
- **Configurable, not hard-coded.** No magic strings, dates or counts in code or
  tests; they go in config or fixture JSON. Engines and tools are swappable and
  stack-agnostic (SOLID, pipeable), and every engine's timings are measured and
  stored.
- **Local-first.** No CI jobs and no CI credits; checks run locally.
  Non-commercial or dev licences are fine for now.
- **Do not invent conventions.** Look for an existing cross-tool standard first
  (`AGENTS.md`, `.agents/`, skills.sh, ce-handoff). Do not add `.claude/` project
  settings by hand.
- **Small, assertable steps.** Fast tasks first. Always confirm the code runs
  (a smoke run, not only tests).
- **PRs:** one feature branch and one PR per task, always `--base main`; never stack
  a PR on another PR branch. The operator merges. After a merge:
  `git switch main && git pull --ff-only`.
- **Auto mode blocks** force-push, branch deletes, and scripted conflict resolution
  during a rebase. Use `git merge main`, and hand branch-delete commands to the
  operator (without a `!` prefix).
- **"Continuous engineering"** means the Compound Engineering `ce-*` skills
  (`ce-compound` for learnings plus CHANGELOG).
- **Handoffs:** past about 30% context, write a detailed handoff in
  `docs/handoffs/` and update its `README.md` index.
- **Headroom** (local proxy, v0.9.68) stays on (decisions H1-H3, clone-cleanup-1
  7.8). Verifying steps write output to a file and read it back, call
  `headroom_retrieve` on any compression marker, and never treat "N items
  compressed" as the full result. If a request runs with Headroom off or bypassed,
  say so in a warning line at the start and the end of the response.
- No emojis or icon glyphs in code, docs, output or PR bodies.

## 3. Sessions so far

All of these ran in substack-dumper. Its handoffs and `CHANGELOG.md` have the full
detail.

| Date | Session (handoff) | What came out of it |
|---|---|---|
| 2026-11-25/26 | ruff-and-code-quality, coverage-and-complexity | local QA pipeline (`qa/pipeline.json`, `scripts/qa.py`, `scripts/dev/qa.sh`), ruff fix batches, coverage tests (#28-#34) |
| 2026-11-26/27 | complexity-splits 1-8 | functions over the complexity limit split, one PR per family (#35-#65); the pattern "old vs new comparison before merge" starts here |
| 2026-11-27 | clone-cleanup-1 | #67: start-up helpers, atomic JSON writer and `now_iso` each moved to one owner (pyscn clone groups 25 to 19). Grilling: the shared-methods skill (section 6) and this skills repo (section 7) |
| 2026-11-27 | shared-methods-1 | #69: the `compound-packs/shared-methods/` pack (`registry.json` as the source of truth, generated rule files, allowlists that may only shrink), the vendored `scripts/shared_methods.py`, and the skill. #71: the WARNING rule |
| 2026-11-27 | earcanjos-skills-1 | this repo's #1 (four skills, mattpocock layout, plugin, changesets, ADRs 0001-0002); substack-dumper #72 installs them as `earcanjos-*` from commit `f947ebb`, with no local copies |
| 2026-11-27 | clone-cleanup-2 | the skill's `audit` mode on substack-dumper: 22 groups; #74-#77 close 8 (`ResilientClient`, `PageClient._probe` / `_send`, YouTube text helpers, preflight helpers), each with a seeded old-vs-new comparison; main at 14 groups, duplication 3.03% to 2.05%. A new registry concept, `page-probe` |

What the skill proved in practice: `audit` ranks candidates, a refactor moves code
into an owner, `update` shrinks the allowlist or adds a concept, and the vendored
test keeps the registry honest (no new offenders, no stale entries, no drift).

One gap found in clone-cleanup-2: `load_registry` accepts a duplicate JSON key
silently (`json.load` keeps the last one). Make it fail with `object_pairs_hook`,
add a test, and bump the skill (section 8).

## 4. State of this repo

- `main` at `f947ebb`, version `0.1.0`, one merged PR (#1).
- Skills: `skills/engineering/human-commit`, `human-pr`,
  `refactor-update-shared-methods`; `skills/productivity/override-warning`. Each has
  a docs page under `docs/<bucket>/`.
- `.claude-plugin/plugin.json` and `marketplace.json`, changesets,
  `scripts/link-skills.sh`, `list-skills.sh`, `sync-plugin-version.mjs`.
- No LICENSE yet (the plugin-directory check wants one before any submission).
- Not built yet (clone-cleanup-1 section 7): `kit/` (move in
  `automation/agents-compatibility`, kit v6 at `a7b102b`), `agents.json` (install
  method per agent and source, plus `interposers`), `specs/stack-spec/` 1.0.0,
  `stacks/`, the `stack-add` / `stack-review` skills, the Headroom A/B (H4, H5).
- Consumers: substack-dumper only, pinned at `f947ebb` in its `skills-lock.json`.
  It vendors `scripts/shared_methods.py`, and a test there fails when the copy
  differs from the installed skill.

## 5. The question for this session: TypeScript repos

The operator asked: what do we do when the project is TypeScript, like
`moura-imobiliario/viabilidade`, `inquerito-casa` or others? The pilot order in
section 7.5 is viabilidade, then inquerito-casa, then `trading/mnq`.

### 5.1 What the three repos have today (surveyed 2026-11-27, not in depth)

| Repo | Stack | Checks | Agent setup |
|---|---|---|---|
| `automation/moura-imobiliario/viabilidade` (`e618e28`) | TypeScript, Node ESM, `tsx`, Cloudflare `wrangler`, Netlify/Vercel config | `fallow` (`npm run fallow`, `fallow:check`: dead code, dupes, health), `tsc --noEmit`; no test runner in `package.json` | `AGENTS.md` is a fallow template with empty sections; `.agents/skills`; `skills-lock.json` with one external skill (`GoogleChrome/modern-web-guidance`); `.claude`, `.cursor`, `.omo`, `.codegraph`, `.mcp.json`; `0-delete/` |
| `automation/inquerito-casa` (`47f5d1f`) | Vue 3, Vite, PWA, `packages/` workspace | vitest (+ coverage-v8, jsdom), `vue-tsc` typecheck, oxlint, oxfmt | no `AGENTS.md`, `HANDOFF.md` at the root; a local `skills/` folder with 8 `survey-*` skills; `.agents/` holds `extracted/`, `scripts/`, `sessions/` (`node --test` files, which vitest must exclude); no `skills-lock.json` |
| `automation/trading/mnq` (`578f77e`) | TypeScript monorepo (turbo), `packages/` | vitest, biome lint, `tsc` typecheck, `npm run checks` / `preflight` | `AGENTS.md`; `.agents/` with `skills/` (openspec and others, 21), `commands`, `memory`, `models`, `scripts` (kit v6 `resume.ts`), `skills-lock.json`; `.opencode`, `.cursor`, `.claude`; openspec |

### 5.2 Which of our skills are tied to Python

- `human-commit`, `human-pr`, `override-warning`: none. They name no language,
  tool or path, so they work as-is in any repo once installed with the `earcanjos-`
  prefix.
- `refactor-update-shared-methods`: tied to Python in five places.
  1. **Scan paths:** `scan.<stack>` in the registry needs `paths_from` (a JSON
     file) plus `paths_key`. In substack-dumper that file is `qa/pipeline.json`.
     None of the TypeScript repos has one. `scripts/shared_methods.py`
     `scan_files()` reads it.
  2. **Script language:** `scripts/shared_methods.py` is Python (stdlib). TS repos
     run their agent scripts as `node <file>.ts` (the kit's `resume.ts`, Node 24
     type stripping). Python 3 is on this machine, but nothing says it is on every
     machine a TS repo is opened on.
  3. **Test template:** only `templates/python/test_shared_methods.py`. TS repos
     need the same four checks (drift, new offender, stale allowlist entry, missing
     files) in vitest or `node --test`, and inquerito-casa must keep those out of
     its vitest run.
  4. **Clone detector in `audit` step 1:** "for Python, pyscn". TS repos already
     have candidates: viabilidade runs `fallow dupes`, and substack-dumper's QA
     pipeline already runs `jscpd` (stack-agnostic) next to pyscn.
  5. **Templates and examples:** the example rule is Python (`tmp.replace(`,
     `write_text(json.dumps(`). A TS concept needs `use.typescript`,
     `wraps.typescript`, `instead_of.typescript` and a `scan.typescript` entry.
     The schema already allows this ("a new stack adds keys, nothing else").

### 5.3 Other things in the way

- inquerito-casa's local `skills/survey-*` and mnq's local `.agents/skills/` are the
  same kind of exception ADR 0002 removed in substack-dumper. Each one either moves
  here (into a bucket), is installed from its own source with a prefix, or gets an
  ADR that changes the rule.
- viabilidade's `AGENTS.md` is still the fallow template. Fill it (commands, layout,
  owner modules) before the shared-methods rules can name owners there.
- The stack spec (7.5) is the planned home of "which tool per step per stack"
  (`clones: pyscn | fallow | jscpd`). Without it, every project hard-codes its
  detector, which breaks the no-magic-strings rule.

## 6. Decisions to grill (none are taken yet)

Use `mattpocock-skills:grilling`, one question at a time, each with a recommended
answer. Record each answer as an ADR in `.agents/adr/`.

1. **Scan paths without `qa/pipeline.json`.** (a) Require every project to have
   the stack spec's pipeline file (wait for 7.5); (b) also allow a literal
   `"paths": [...]` under `scan.<stack>`; (c) read the project's own config
   (`tsconfig.json` `include`, `package.json` `workspaces`). Recommended: (b) now,
   since it is the smallest change and works in every stack; switch to (a) once the
   stack spec exists. Note that (b) is a schema addition (`shared-methods@1` stays
   compatible).
2. **One script or two.** (a) Keep the Python script for every stack; (b) port it
   to TypeScript and ship both; (c) port to TypeScript only. "No exceptions" argues
   against (b). Check what mattpocock/skills does with shipped code before deciding.
   Measure the Python script's run time on viabilidade first.
3. **The TS test template.** vitest (what inquerito-casa and mnq use) or
   `node --test` (no dependency, already used for `.agents/` scripts). Recommended:
   `node --test` under `.agents/`, kept out of vitest like inquerito-casa already
   does, unless the operator wants the check in the project's normal test run.
4. **Clone detector per stack.** fallow (TS-only, already in viabilidade), jscpd
   (any stack, already in substack-dumper's pipeline), or both. This is a
   `stack-review` entry: measure both on viabilidade (time, findings, licence,
   last release) and record it.
5. **Local project skills** (inquerito-casa `survey-*`, mnq's openspec set): move
   them here, install them from their source with a prefix, or allow project-local
   skills by ADR.
6. **Order:** this TS work before or after the kit move and `agents.json`
   (section 4). The kit's `setup.ts` would install the skills per agent, so the
   pilot may want it first.

## 7. Pilot plan (after the grilling)

On `moura-imobiliario/viabilidade`, one PR per step, each with a smoke run:

1. Fill its `AGENTS.md` (commands, entry points, directories). Ask the operator for
   anything the code does not show.
2. Install our four skills with the prefix (`DISABLE_TELEMETRY=1 npx skills add
   earcanjos-development/skills --skill <name> --rename earcanjos-<name> --agent
   claude-code codex cursor github-copilot opencode -y`; put the source before
   `--agent`), plus `config.skillPrefixes` in its `package.json`.
3. Run `refactor-update-shared-methods` `install` with the TS answers from section
   6: registry with `scan.typescript`, the vendored script, the test, and the CE
   pack registration in `.compound-engineering/config.yaml`.
4. Run `audit`: the clone detector from decision 4, then `SM scan`; rank the
   candidates. Write the first real TS concept from what the audit finds, not from
   a guess.
5. Back here: the skill changes (TS template, scan option, docs page), a changeset
   and a version bump, then update the lock in viabilidade and substack-dumper
   (`npx skills update -p -y`, review the diff, and re-copy the vendored script in
   substack-dumper).

Then inquerito-casa (Vue: `.vue` files in `suffixes`; vitest exclusion) and
trading/mnq (monorepo; already on kit v6).

## 8. Carried over

- **Duplicate-key guard** in `load_registry` (section 3), with a test. Bump the
  skill, then re-vendor it in substack-dumper.
- **LICENSE** for this repo: ask which licence.
- **Kit move, `agents.json`, stack spec 1.0.0, `stack-add` / `stack-review`:**
  clone-cleanup-1 sections 7.2-7.6.
- **Headroom A/B** (H4: tokens, latency and stalls with and without the bypass
  header) and H5 (the remaining AppSumo pages).
- **Unlearn skills:** keep all 17 until the `agent_usage.py --record` run in
  substack-dumper on or after 2026-12-02, then keep only those used.

## 9. Facts worth knowing

- substack-dumper: the operator merged #74-#77 during the clone-cleanup-2 session,
  some while later PRs were still being written. Check PR state before merging
  `main` into a branch.
- `gh pr create` and `gh pr view` sometimes fail with GraphQL errors. Use
  `gh api repos/<owner>/<repo>/pulls...`, and check for an existing PR before
  retrying.
- `claude plugin validate .` must print "Validation passed" after any
  `.claude-plugin/` change; the `CLAUDE.md` warning is expected (ADR 0001).
- substack-dumper's handoff for its own remaining work:
  `automation/substack-dumper/docs/handoffs/2026-11-27-clone-cleanup-2-handoff.md`.
