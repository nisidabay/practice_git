# Group 08 — cherry-pick: Grab just one commit

## Quick Start

```bash
bash 01_single_pick.sh
bash 02_multiple_picks.sh
bash 03_conflict_resolution.sh
bash 04_cherry_vs_merge.sh
bash 05_signoff_flag.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_single_pick.sh` | grab one commit | New hash, same changes — no need to merge the whole branch |
| `02_multiple_picks.sh` | pick a range | `A..B` = commits after A through B |
| `03_conflict_resolution.sh` | handling conflicts | Same as merge conflicts: edit, add, continue |
| `04_cherry_vs_merge.sh` | merge vs pick | Merge = same hash. Pick = new hash → use -D to delete |
| `05_signoff_flag.sh` | record the source | `-x` adds a breadcrumb back to the original commit |

## Common Patterns

```bash
git cherry-pick <hash>                   # pick one commit
git cherry-pick A..B                     # pick a range (A exclusive, B inclusive)
git cherry-pick -x <hash>               # pick + record origin
git cherry-pick --continue              # after resolving conflicts
git cherry-pick --abort                 # bail out
git branch -D <branch>                  # after cherry-pick, need force delete
```

## Now Build Your Own

Create two branches off main. On branch A, make 3 commits (files a1, a2, a3).
On branch B, make 1 commit. Cherry-pick B's commit AND a2 from A onto main.
Verify with `git log --oneline` that you have exactly those two new commits.
