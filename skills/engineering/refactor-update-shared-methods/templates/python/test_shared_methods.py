"""Shared-methods pack: generated rules match the registry, and the
`instead_of` patterns appear only in each rule's owner or its allowlist.

Template from earcanjos-development/skills (refactor-update-shared-methods).
Copy to tests/ next to scripts/shared_methods.py. All data comes from the
registry.
"""

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

import shared_methods as sm

REGISTRY = sm.load_registry()


def test_generated_rules_match_registry():
    problems = sm.drift(REGISTRY)
    assert not problems, f"{problems}; {sm.FIX}"


def test_no_new_offenders_outside_owner():
    new, _ = sm.violations(REGISTRY)
    assert not new, f"shared concept written outside its owner: {new}"


def test_allowlist_only_shrinks():
    _, stale = sm.violations(REGISTRY)
    assert not stale, f"remove fixed files from the registry allowlist: {stale}"


def test_owners_and_allowlisted_files_exist():
    missing = [path for rule in REGISTRY["rules"]
               for path in [rule["owner"], *rule.get("allowlist", {})]
               if not (ROOT / path).is_file()]
    assert not missing, f"registry names files that do not exist: {missing}"
