# Group 05 — rebase: Rewrite history

## Quick Start

```bash
bash 01_squash_commits.sh
bash 02_drop_commits.sh
bash 03_reword_messages.sh
bash 04_reorder_commits.sh
bash 05_fixup_autosquash.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_squash_commits.sh` | combine commits | `pick` + `squash` = one clean commit from many WIP ones |
| `02_drop_commits.sh` | delete commits | `drop` removes a commit AND its files from history |
| `03_reword_messages.sh` | fix messages | `reword` changes the message without touching code |
| `04_reorder_commits.sh` | change order | swap lines in the todo list (only for independent commits) |
| `05_fixup_autosquash.sh` | automated squashing | `--fixup` + `--autosquash` = no manual todo list |

## Common Patterns

```bash
git rebase -i HEAD~4              # edit the last 4 commits
# In the editor:
#   pick → squash  = combine into previous commit
#   pick → drop    = delete this commit
#   pick → reword  = change only the message
#   reorder lines  = change commit order

# Fixup workflow (no interactive editor needed):
git commit --fixup=<hash>
git rebase -i --autosquash HEAD~5
```

## Now Build Your Own

In a throwaway repo, make 5 commits with bad messages and WIP content.
Open an interactive rebase with `git rebase -i HEAD~5`. Practice: squash
2-3 into 4, reword 1, reorder 2 of them. Verify with `git log --oneline`.
