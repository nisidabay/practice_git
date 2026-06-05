#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_cherry_vs_merge.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. Merge approach: pull all commits from a branch
# ============================================================
git checkout -b feature 2>/dev/null
echo "Feature work" > feature.txt
git add feature.txt
git commit -m "Feature work" > /dev/null

git checkout main 2>/dev/null
git merge feature --no-ff -m "Merge feature" > /dev/null

echo "=== After merge: ==="
git log --oneline --graph

echo ""
echo "=== Deleting feature branch: git branch -d feature ==="
echo "(Git knows it was merged — safe delete)"
git branch -d feature 2>/dev/null || echo "(already on main)"

# ============================================================
# 2. Cherry-pick approach: grab one commit, different hash
# ============================================================
# Reset and try cherry-pick instead
git checkout main 2>/dev/null

echo ""
echo "=== Merge vs Cherry-pick: ==="
echo "  MERGE:       original hash preserved → git knows it's merged → -d works"
echo "  CHERRY-PICK: NEW hash created → git thinks branch is unmerged → need -D"
echo ""
echo "=== After cherry-pick, always use: git branch -D (force delete) ==="

cd /tmp
rm -rf "$PLAYGROUND"
