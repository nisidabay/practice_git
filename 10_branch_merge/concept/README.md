# Group 10 — branch & merge: Work in isolation

## Quick Start

```bash
bash 01_branch_basics.sh
bash 02_fast_forward.sh
bash 03_merge_no_ff.sh
bash 04_merge_conflicts.sh
bash 05_delete_cleanup.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_branch_basics.sh` | create, switch, list | `git switch -c` is the modern way to create + move |
| `02_fast_forward.sh` | linear merge | No new commits on main → pointer just moves forward |
| `03_merge_no_ff.sh` | explicit merge commit | `--no-ff` preserves "a branch was merged here" |
| `04_merge_conflicts.sh` | conflict anatomy | `<<< HEAD` = yours, `===` = separator, `>>> branch` = theirs |
| `05_delete_cleanup.sh` | -d vs -D | -d is safe (merged only), -D is force (you might lose work) |

## Common Patterns

```bash
git switch -c feature/login          # create and switch
git switch main                      # go back to main
git merge feature/login              # merge (fast-forward if possible)
git merge --no-ff feature/login      # always create a merge commit
git merge --abort                    # bail out of a conflict
git branch -d feature/login          # safe delete (merged only)
git branch -D feature/login          # force delete (unmerged)
git log --oneline --graph --all      # visualize everything
```

## Now Build Your Own

Create 3 branches: feature/A, feature/B, hotfix/C. Make 2 commits on each.
Merge feature/A with fast-forward. Merge feature/B with --no-ff. Merge hotfix/C
and resolve a conflict you intentionally created. Delete all branches with -d.
Use `git log --oneline --graph --all` after each merge to visualize the history.
