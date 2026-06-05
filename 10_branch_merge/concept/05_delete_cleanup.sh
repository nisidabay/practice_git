#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_delete_cleanup.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. Create and merge a branch (safe delete with -d)
# ============================================================
git checkout -b feature 2>/dev/null
echo "Feature" > feature.txt
git add feature.txt
git commit -m "Feature" > /dev/null

git checkout main 2>/dev/null
git merge feature 2>/dev/null

echo "=== git branch -d feature (after merge — works): ==="
git branch -d feature 2>/dev/null && echo "Deleted!" || echo "Failed!"
echo ""

# ============================================================
# 2. Create an unmerged branch (need -D)
# ============================================================
git checkout -b unmerged 2>/dev/null
echo "Unmerged" > unmerged.txt
git add unmerged.txt
git commit -m "Unmerged work" > /dev/null

git checkout main 2>/dev/null

echo "=== git branch -d unmerged (not merged — fails): ==="
git branch -d unmerged 2>/dev/null && echo "Deleted!" || echo "Failed (expected)"
echo ""

echo "=== git branch -D unmerged (force — works): ==="
git branch -D unmerged 2>/dev/null && echo "Force deleted!" || echo "Failed!"

echo ""
echo "=== -d = delete only merged branches (safe) ==="
echo "=== -D = force delete even if unmerged (you lose those commits) ==="
echo "=== After cherry-pick, Git doesn't recognize the merge — always use -D ==="

cd /tmp
rm -rf "$PLAYGROUND"
