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
FEATURE_HASH=$(git rev-parse HEAD)

git checkout main 2>/dev/null
git merge feature --no-ff -m "Merge feature" > /dev/null

echo "=== After merge: ==="
git log --oneline --graph --all

echo ""
echo "=== git branch -d feature (Git knows it was merged) ==="
git branch -d feature 2>/dev/null && echo "Deleted — safe because merge preserved original hash."

# ============================================================
# 2. Cherry-pick approach: grab a commit from an UNRELATED branch
# ============================================================
git checkout -b hotfix HEAD~1 2>/dev/null
echo "Hotfix work" > hotfix.txt
git add hotfix.txt
git commit -m "Hotfix work" > /dev/null
HOTFIX_HASH=$(git rev-parse HEAD)

git checkout main 2>/dev/null
git cherry-pick "$HOTFIX_HASH" > /dev/null 2>&1

echo ""
echo "=== After cherry-pick: ==="
git log --oneline --graph --all

echo ""
echo "=== git branch -d hotfix (Git thinks it's unmerged — fails): ==="
git branch -d hotfix 2>&1 | head -2 || true

echo ""
echo "=== git branch -D hotfix (force delete — works): ==="
git branch -D hotfix 2>/dev/null && echo "Force deleted."

echo ""
echo "=== Merge vs Cherry-pick: ==="
echo "  MERGE:       original hash preserved → git knows it's merged → -d works"
echo "  CHERRY-PICK: NEW hash created → git thinks branch is unmerged → need -D"

cd /tmp
rm -rf "$PLAYGROUND"
