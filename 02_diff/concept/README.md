# Group 02 — diff: Compare anything

## Quick Start

```bash
bash 01_unstaged_diff.sh
bash 02_staged_diff.sh
bash 03_branch_diff.sh
bash 04_word_diff.sh
bash 05_range_diff.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_unstaged_diff.sh` | working tree vs index | `git diff` shows what you haven't staged |
| `02_staged_diff.sh` | index vs HEAD | `git diff --staged` shows what you're about to commit |
| `03_branch_diff.sh` | two branches | `main..feature` = what feature has that main doesn't |
| `04_word_diff.sh` | word-level precision | `--word-diff` pinpoints which word changed |
| `05_range_diff.sh` | commit ranges | `HEAD~3..HEAD` = "what changed in the last 3 commits" |

## Common Patterns

```bash
git diff                  # what did I change (unstaged)?
git diff --staged         # what am I about to commit?
git diff main..feature    # what's different on that branch?
git diff --word-diff      # which WORD changed?
git diff HEAD~3..HEAD     # cumulative changes from last 3 commits
git diff --stat           # just the filenames and change counts
git diff --name-only      # just the filenames
```

## Now Build Your Own

Pick your dotfiles repo (or any project with 10+ commits). Run `git diff HEAD~5..HEAD`
and read the output. Then run `git diff --stat` for the same range. Then use
`--name-only`. Which format tells you what you need fastest?
