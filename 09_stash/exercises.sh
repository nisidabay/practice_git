#!/bin/bash
# exercises.sh — Stash group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: basic push/pop ===
git init
echo "base" > base.txt; git add base.txt; git commit -m "Base" > /dev/null
echo "WIP" >> base.txt

echo "Before stash: $(git status --short)"
git stash push -m "my WIP" 2>/dev/null
echo "After stash (clean): $(git status --short)"
git stash pop 2>/dev/null
echo "After pop: $(git status --short)"
echo "---"

# === Exercise 2: stash -u for untracked files ===
echo "brand new" > new.txt
git stash push -u -m "with untracked" 2>/dev/null
echo "Untracked stashed: $(ls -1 | grep new || echo 'none')"
git stash pop 2>/dev/null
echo "Untracked recovered: $(ls -1 | grep new)"
echo "---"

# === Exercise 3: stash branch ===
git stash push -m "should be a branch" 2>/dev/null
echo "Created stash@{0}"
git stash branch from-stash stash@{0} 2>/dev/null
echo "New branch: $(git branch --show-current)"
echo "Changes applied: $(cat base.txt)"
echo "---"

# === Exercise 4: stash list/apply/drop ===
git checkout main 2>/dev/null
echo "first" >> base.txt; git stash push -m "first" 2>/dev/null
echo "second" >> base.txt; git stash push -m "second" 2>/dev/null
echo "Stash list:"
git stash list
echo "Showing stash@{1}:"
git stash show stash@{1}
git stash drop stash@{1} 2>/dev/null
echo "After dropping stash@{1}:"
git stash list
echo "---"

# === BONUS ===
echo "git stash pop stash@{N} = pop a specific stash"
echo "git stash clear = delete ALL stashes (no undo)"

rm -rf "$PG"
