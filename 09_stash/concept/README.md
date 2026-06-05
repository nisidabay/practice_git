# Group 09 — stash: Save work in progress

## Quick Start

```bash
bash 01_stash_push_pop.sh
bash 02_stash_untracked.sh
bash 03_stash_branch.sh
bash 04_stash_partial.sh
bash 05_stash_list_manage.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_stash_push_pop.sh` | save and restore | stash = snapshot your dirty working tree and clean it |
| `02_stash_untracked.sh` | include new files | `-u` stashes untracked files too |
| `03_stash_branch.sh` | recover as branch | `git stash branch` = "I should have started a branch" |
| `04_stash_partial.sh` | patch-level stash | `-p` lets you choose which hunks to stash |
| `05_stash_list_manage.sh` | multiple stashes | apply vs pop vs drop vs clear |

## Common Patterns

```bash
git stash push -m "message"      # save with a name
git stash push -u                # include untracked files
git stash push -p                # pick specific hunks
git stash pop                    # restore + delete latest stash
git stash apply                  # restore but keep in list
git stash list                   # show all stashes
git stash drop stash@{2}         # delete a specific stash
git stash branch <name>          # recover a stash as a new branch
git stash clear                  # delete ALL stashes (no undo)
```

## Now Build Your Own

Start editing 3 files (modify one, add a new one, delete another). Run `git stash -u`
to save everything. Verify `git status` is clean. Switch branches, do something,
then `git stash pop` to get your work back. The stash is Git's "pause button."
