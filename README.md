# Git Practice — Core CLI, Solo Workflow

A progressive, code-first curriculum for mastering Git's core commands.
No GitHub, no remotes, no collaboration — just the tool itself.

## Who This Is For

- You use `git add`, `git commit`, `git push` and want to go deeper
- You've lost work to a bad reset and want a safety net
- You want to understand diff, rebase, and cherry-pick at the command level

## What You'll Learn

Each group focuses on one command or concept family:

| Group | Topic | The key skill |
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

## How It Works

Every concept file is a standalone bash script. It creates its own temporary
playground, runs the commands, shows the output, and cleans up. Run it anywhere:

```bash
# From the repo root
cd 01_foundation/concept
cat README.md             # See what you'll learn
bash 01_init_add_commit.sh  # Run the first concept
```

Each group also has:

- **exercises.sh** — solved problems (read it, run it, then modify it)
- **project/** — a real CLI tool built from that group's concepts
- **README.md** — Quick Start table, learning path, patterns, build-your-own

## Start Here

```bash
cd 01_foundation/concept
cat README.md
bash 01_init_add_commit.sh
```
