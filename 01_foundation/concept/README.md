# Group 01 — Foundation: init, add, commit, status, log

## Quick Start

```bash
bash 01_init_add_commit.sh
bash 02_status_inspection.sh
bash 03_three_stages.sh
```

## Learning Path

| File | Concept | Key Insight |
|------|---------|-------------|
| `01_init_add_commit.sh` | init → add → commit cycle | `git add` is a staging step — it doesn't commit |
| `02_status_inspection.sh` | status, log, log --oneline | `status` tells you where each file is; `log` tells you when |
| `03_three_stages.sh` | Working tree, index, HEAD | `git diff` vs `git diff --staged` — two different comparisons |

## Common Patterns

```bash
# The daily cycle
git status                           # where am I?
git diff                             # what did I change?
git add <file>                       # stage it
git diff --staged                    # verify what will commit
git commit -m "message"              # save it in history
git log --oneline                    # check the timeline
```

## Now Build Your Own

Initialize a repo for one of your existing projects that isn't tracked yet.
Make the first commit. Use `git status` and `git diff` at each step — don't
skip the verification. After 3 commits, read `git log --oneline --graph`.
