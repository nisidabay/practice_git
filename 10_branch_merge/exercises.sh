#!/bin/bash
# exercises.sh — Branch & Merge group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: create, switch, list branches ===
git init
echo "base" > base.txt; git add base.txt; git commit -m "Base" > /dev/null

git switch -c feature 2>/dev/null
echo "branches:"; git branch
echo "current: $(git branch --show-current)"
echo "---"

# === Exercise 2: fast-forward merge ===
echo "FF work" > ff.txt; git add ff.txt; git commit -m "FF work" > /dev/null
git switch main 2>/dev/null
git merge feature 2>/dev/null

echo "After fast-forward (no merge commit):"
git log --oneline --graph
echo "---"

# === Exercise 3: merge with --no-ff ===
git switch -c side 2>/dev/null
echo "side" > side.txt; git add side.txt; git commit -m "Side" > /dev/null
git switch main 2>/dev/null
git merge --no-ff side -m "Merge side" 2>/dev/null

echo "After --no-ff (merge commit present):"
git log --oneline --graph
echo "---"

# === Exercise 4: conflict resolution cycle ===
echo "initial" > conflict.txt; git add conflict.txt; git commit -m "conflict base" > /dev/null

git switch -c left 2>/dev/null
sed -i 's/initial/left version/' conflict.txt; git add conflict.txt; git commit -m "Left" > /dev/null

git switch main 2>/dev/null
sed -i 's/initial/right version/' conflict.txt; git add conflict.txt; git commit -m "Right" > /dev/null

echo "Merge with conflict:"
git merge left 2>/dev/null || echo "(conflict — as expected)"
git merge --abort 2>/dev/null
echo "Aborted — back to clean"
echo "---"

# === Exercise 5: -d vs -D ===
git switch -c temp 2>/dev/null
echo "temp" > temp.txt; git add temp.txt; git commit -m "Temp" > /dev/null
git switch main 2>/dev/null

echo "git branch -d temp (unmerged — fails):"
git branch -d temp 2>&1 | head -1 || true
echo "git branch -D temp (force — works):"
git branch -D temp 2>/dev/null && echo "deleted"
echo "---"

# === BONUS ===
echo "Branch workflow summary:"
echo "  git switch -c <name>     # create + switch"
echo "  git merge <branch>       # merge (fast-forward if possible)"
echo "  git merge --no-ff        # always create merge commit"
echo "  git branch -d <name>     # safe delete (merged only)"
echo "  git branch -D <name>     # force delete (any state)"

rm -rf "$PG"
