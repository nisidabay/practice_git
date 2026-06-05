# Group 04 — revert: Undo a published commit safely

## Quick Start

```bash
bash 01_revert_basics.sh
bash 02_revert_range.sh
bash 03_revert_merge.sh
bash 04_revert_vs_reset.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_revert_basics.sh` | undo via new commit | `git revert` creates a NEW commit, history grows |
| `02_revert_range.sh` | undo multiple commits | `OLDEST..NEWEST` reverts everything between them |
| `03_revert_merge.sh` | undoing a merge | Merge commits need `-m 1` or `-m 2` |
| `04_revert_vs_reset.sh` | when to use which | Pushed = revert. Local only = reset. |

## Common Patterns

```bash
git revert <commit>               # undo a single commit
git revert HEAD~3..HEAD           # undo the last 3 commits
git revert --no-edit <commit>     # skip the editor (uses default message)
git revert -m 1 <merge-commit>    # undo a merge, keep main-line history
git revert --abort                # bail out of a revert in progress
```

## Now Build Your Own

Create 5 commits in a throwaway repo. Intentionally put a bad change in commit #3.
Use `git log` to find its hash, then `git revert` it. Verify with `git log` that
the old commit still exists AND there's a new revert commit. Then revert the revert.
