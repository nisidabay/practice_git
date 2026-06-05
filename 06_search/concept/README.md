# Group 06 — search: Find anything in your history

## Quick Start

```bash
bash 01_log_filters.sh
bash 02_log_pickaxe.sh
bash 03_log_diff_search.sh
bash 04_git_grep.sh
bash 05_git_blame.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_log_filters.sh` | --grep, --since, --author | Combine filters to narrow down commits |
| `02_log_pickaxe.sh` | -S (pickaxe) | Find commits where a string count changed |
| `03_log_diff_search.sh` | -G (regex in patch) | Match regex in the diff, not the file |
| `04_git_grep.sh` | search working tree + history | git grep works in any commit, not just HEAD |
| `05_git_blame.sh` | who wrote each line | Track every line to the commit that last touched it |

## Common Patterns

```bash
git log --grep="fix" --since="2024-01-01"    # commits with 'fix' since Jan
git log -S "TODO"                             # when was TODO added/removed?
git log -G "import.*deprecated"               # commits with deprecated imports
git grep "FIXME"                              # all tracked files with FIXME
git grep "FIXME" HEAD~5                       # FIXMEs as of 5 commits ago
git blame file.txt                            # who wrote each line?
git blame -L10,20 file.txt                    # who wrote lines 10-20?
```

## Now Build Your Own

In your dotfiles repo, use `git log -S` to find the commit that introduced
a specific config line. Then use `git blame` on that file to verify when each
line was last touched. The two tools together tell the full story.
