# Group 03 — restore: Undo before it hits history

## Quick Start

```bash
bash 01_discard_unstaged.sh
bash 02_unstage_files.sh
bash 03_restore_from_commit.sh
bash 04_checkout_vs_restore.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_discard_unstaged.sh` | revert working tree | `git restore <file>` = "take it back to staged state" |
| `02_unstage_files.sh` | move from index to working tree | `--staged` touches index only, working tree unchanged |
| `03_restore_from_commit.sh` | time-travel one file | `--source=<commit>` pulls a past version into working tree |
| `04_checkout_vs_restore.sh` | old vs new commands | `git checkout --` → `git restore`, `reset HEAD` → `restore --staged` |

## Common Patterns

```bash
git restore file.txt               # discard unstaged changes to file.txt
git restore --staged file.txt      # unstage file.txt (keep changes in working tree)
git restore --source=HEAD~3 file.txt  # restore file.txt from 3 commits ago
git restore .                      # discard ALL unstaged changes (careful!)
git restore --staged .             # unstage EVERYTHING
```

## Now Build Your Own

Delete a file from your working tree (not from git — just `rm` it). Use `git status`
to confirm it shows as deleted. Then use `git restore <file>` to bring it back.
This is the fix for "I accidentally deleted a tracked file."
