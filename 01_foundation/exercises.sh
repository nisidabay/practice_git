#!/bin/bash
# exercises.sh — Foundation group. Solved problems you can run and modify.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: First repo ===
# Task: Create a repo, make TWO commits, verify with log
git init
echo "repo start" > start.txt
git add start.txt
git commit -m "Begin" > /dev/null
echo "repo v2" >> start.txt
git add start.txt
git commit -m "Update" > /dev/null
git log --oneline
echo "---"

# === Exercise 2: Read the three stages ===
# Task: Modify a committed file, check diff vs diff --staged
echo "base" > stages.txt
git add stages.txt
git commit -m "base" > /dev/null
echo "changed" >> stages.txt
echo "Unstaged diff (working tree vs index):"
git diff
echo "(empty above means working tree matches index)"
echo "Staged diff (index vs HEAD) should be empty:"
git diff --staged
echo "---"

# === Exercise 3: Stage and see the shift ===
# Task: Stage the change, observe diff --staged now shows it
git add stages.txt
echo "After staging — unstaged diff should be empty:"
git diff
echo "After staging — staged diff should show the change:"
git diff --staged
echo "---"

# === Exercise 4: Status tells the story ===
# Task: git status summarizes all three stages
git status
echo "---"

# === BONUS ===
# Task: Make a third commit, check log shows 3 entries
git commit -m "third" > /dev/null
git log --oneline
echo "(verify you see 3 commits — count'em)"

rm -rf "$PG"
