#!/bin/bash
# exercises.sh — Rebase group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: squash 3 WIP commits into 1 ===
git init
echo "base" > README.md; git add README.md; git commit -m "base" > /dev/null
echo "step 1" > feature.txt; git add feature.txt; git commit -m "WIP" > /dev/null
echo "step 2" >> feature.txt; git add feature.txt; git commit -m "fix" > /dev/null
echo "step 3" >> feature.txt; git add feature.txt; git commit -m "final" > /dev/null

echo "Before (3 WIP commits):"
git log --oneline | grep -v base
echo "---"

GIT_SEQUENCE_EDITOR="sed -i '2,\$s/^pick/squash/'" GIT_EDITOR=true \
git rebase -i HEAD~3
echo "After (1 commit):"
git log --oneline | grep -v base
echo "---"

# === Exercise 2: drop a commit ===
rm -rf .git
git init
echo "base" > README.md; git add README.md; git commit -m "base" > /dev/null
echo "bad" > bad.txt; git add bad.txt; git commit -m "BAD COMMIT" > /dev/null
echo "good" > good.txt; git add good.txt; git commit -m "good" > /dev/null

echo "Before drop:"
ls *.txt
echo "---"

GIT_SEQUENCE_EDITOR="sed -i '/BAD/s/^pick/drop/'" GIT_EDITOR=true \
git rebase -i HEAD~2
echo "After drop (bad.txt gone):"
ls *.txt
echo "---"

# === Exercise 3: reorder commits ===
rm -rf .git
git init
echo "base" > README.md; git add README.md; git commit -m "base" > /dev/null
echo "A" > a.txt; git add a.txt; git commit -m "A" > /dev/null
echo "B" > b.txt; git add b.txt; git commit -m "B" > /dev/null
echo "C" > c.txt; git add c.txt; git commit -m "C" > /dev/null

echo "Before: $(git log --oneline | grep -v base | awk '{print $2}' | tr '\n' ' ')"
GIT_SEQUENCE_EDITOR="sed -i '2{h;d}; 3{G}'" GIT_EDITOR=true \
git rebase -i HEAD~3
echo "After:  $(git log --oneline | grep -v base | awk '{print $2}' | tr '\n' ' ')"
echo "---"

# === Exercise 4: fixup workflow ===
rm -rf .git
git init
echo "base" > README.md; git add README.md; git commit -m "base" > /dev/null
echo "main code" > main.c; git add main.c; git commit -m "Add parser" > /dev/null
echo "missing semicolon" >> main.c; git add main.c
git commit -m "fixup! Add parser" > /dev/null

echo "Before fixup (2 commits):"
git log --oneline | grep -v base
GIT_SEQUENCE_EDITOR=true GIT_EDITOR=true \
git rebase -i --autosquash HEAD~2
echo "After fixup (1 commit):"
git log --oneline | grep -v base
echo "---"

# === BONUS ===
echo "Try this on a REAL repo:"
echo "  GIT_SEQUENCE_EDITOR=vim git rebase -i HEAD~5"

rm -rf "$PG"
