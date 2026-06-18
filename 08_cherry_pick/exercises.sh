#!/bin/bash
# exercises.sh — Cherry-pick group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: cherry-pick a single fix ===
git init
echo "base" > base.txt; git add base.txt; git commit -m "Base" > /dev/null

git checkout -b fix 2>/dev/null
echo "PATCH" > patch.txt; git add patch.txt; git commit -m "Critical fix" > /dev/null
FIX=$(git rev-parse HEAD)

git checkout main 2>/dev/null
git cherry-pick "$FIX" 2>/dev/null

echo "After cherry-pick, main has:"
ls -1
git log --oneline
echo "---"

# === Exercise 2: cherry-pick a range ===
git checkout -b more 2>/dev/null
echo "X" > x.txt; git add x.txt; git commit -m "X" > /dev/null
echo "Y" > y.txt; git add y.txt; git commit -m "Y" > /dev/null
echo "Z" > z.txt; git add z.txt; git commit -m "Z" > /dev/null

FIRST=$(git rev-parse HEAD~2)
LAST=$(git rev-parse HEAD)

git checkout main 2>/dev/null
git cherry-pick "$FIRST..$LAST" 2>/dev/null

echo "After cherry-pick range:"
ls -1
echo "---"

# === Exercise 3: cherry vs merge — branch delete difference ===
git checkout -b side 2>/dev/null
echo "side" > side.txt; git add side.txt; git commit -m "Side" > /dev/null
SIDE=$(git rev-parse HEAD)

git checkout main 2>/dev/null
git cherry-pick "$SIDE" 2>/dev/null

echo "Trying git branch -d side (will fail):"
git branch -d side 2>&1 | head -1 || echo "(expected — git doesn't recognize cherry-pick as merge)"
echo "---"

# === Exercise 4: cherry-pick --continue/--abort ===
echo "conflict base" > conflict.txt; git add conflict.txt; git commit -m "Base conflict" > /dev/null

git checkout -b conflict-branch 2>/dev/null
sed -i 's/conflict base/conflict version/' conflict.txt; git add conflict.txt; git commit -m "Change text" > /dev/null
CH=$(git rev-parse HEAD)

git checkout main 2>/dev/null
sed -i 's/conflict base/different base/' conflict.txt; git add conflict.txt; git commit -m "Different text" > /dev/null

echo "Cherry-picking (will conflict):"
git cherry-pick "$CH" 2>/dev/null || echo "(conflict paused)"
git cherry-pick --abort 2>/dev/null
echo "Aborted — clean state:"
git status --short
echo "---"

# === BONUS ===
echo "Rule: Always use -x with cherry-pick to record the source."
echo "  git cherry-pick -x <hash>"
echo "This adds: (cherry picked from commit <hash>) to the message."

rm -rf "$PG"
