# Git Practice — Core CLI, Solo Workflow

A progressive, code-first curriculum for mastering Git's core commands.
No GitHub, no remotes, no collaboration — just the tool itself.

## Who This Is For

- You use `git add`, `git commit`, `git push` and want to go deeper
- You've lost work to a bad reset and want a safety net
- You want to understand diff, rebase, and cherry-pick at the command level
- You read blog posts about "rewriting history" and want to know what that actually means

## Two Paths In

### Path A: The Quick Tour (~20 min)

Pick any group whose topic interests you. Every concept script is self-contained —
it creates its own temp playground, runs the commands, shows the output, and cleans up.
Zero risk to your real repos.

```bash
cd 02_diff/concept
cat README.md              # see the map
bash 01_unstaged_diff.sh   # first concept
bash 02_staged_diff.sh     # next one
```

### Path B: Systematic (~2-3 weeks)

Work through the numbered groups in order. Each group has:

- **concept/README.md** — quick-start table + learning path
- **concept/*.sh** — one concept per file, code-first, self-contained
- **exercises.sh** — solved practice problems at the group level
- **project/** — a real CLI tool using those concepts
- **"Now Build Your Own"** prompt at the bottom of every README

Start here:

```bash
cd 01_foundation/concept
cat README.md
bash 01_init_add_commit.sh
```

Then keep going:

```
01_foundation → 02_diff → 03_restore → 04_revert → 05_rebase
                                                          ↓
06_search ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← 07_reflog → 08_cherry_pick
                                                                     ↓
                                                              09_stash → 10_branch_merge
```

## What You'll Learn

| Group | Topic | The Key Skill |
|-------|-------|--------------|
| 01 | Foundation | init, add, commit, the three stages |
| 02 | diff | Compare anything: working tree, index, branches, commits |
| 03 | restore | Undo before it hits history |
| 04 | revert | Undo a published commit safely |
| 05 | rebase | Rewrite history: squash, drop, reword, reorder |
| 06 | search | Find anything in your history and codebase |
| 07 | reflog | Your safety net — recover from any mistake |
| 08 | cherry-pick | Grab one commit without merging a branch |
| 09 | stash | Save work in progress, switch tasks, come back |
| 10 | branch-merge | Create branches, merge, resolve conflicts |

## The Toolbox

`project/` in each group contains a real CLI tool built from that group's concepts:

| Group | Tool | What It Does |
|-------|------|-------------|
| 01 | `init-template.sh` | Initialize a git repo with README and .gitignore |
| 02 | `diff-report.sh` | Human-readable diff summaries between any two refs |
| 03 | `restore-doctor.sh` | Interactively restore files from history |
| 04 | `undo-history.sh` | Safe commit range undo with abort support |
| 05 | `cleanup-history.sh` | Squash WIP/fixup commits into narrative history |
| 06 | `git-find.sh` | Unified search across log, grep, and blame |
| 07 | `reflog-rescue.sh` | Guided recovery for lost commits and branches |
| 08 | `patch-backport.sh` | Backport a fix from any branch to main |
| 09 | `context-switch.sh` | Save/restore full working state for task-switching |
| 10 | `branch-strategy.sh` | Simulate feature/hotfix/release workflow locally |

## Safety

Every script uses `mktemp -d` — it creates a throwaway playground, runs the
commands, and deletes everything. You can run `git reset --hard` in here all
day and it won't touch your real repos.

## Reading

`REFERENCES.md` — books and resources for going deeper into Git internals.
