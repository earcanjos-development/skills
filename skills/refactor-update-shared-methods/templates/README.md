Which module owns each shared concept in this project, so new code calls it instead of writing a twin or calling the library directly.

- `registry.json` is the source of truth. The other top-level `.md` files are generated from it with `python3 scripts/shared_methods.py render --write`; do not edit them by hand.
- `tests/test_shared_methods.py` fails on drift, on a pattern hit outside the owner, and on an allowlist entry that no longer matches.
- Skill: `refactor-update-shared-methods` from `earcanjos-development/skills`.
