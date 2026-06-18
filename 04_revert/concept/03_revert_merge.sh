#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_revert_merge.sh: playground at $PLAYGROUND"

# ============================================================
# 1. Create a branch and merge it
# ============================================================
git init
echo "main work" > main.txt
git add main.txt
git commit -m "Main commit" > /dev/null

git checkout -b feature 2>/dev/null
echo "feature work" > feature.txt
git add feature.txt
git commit -m "Feature work" > /dev/null

git checkout main 2>/dev/null
git merge --no-ff feature -m "Merge feature" > /dev/null

echo "=== History with merge commit: ==="
git log --oneline --graph
echo ""

# ============================================================
# 2. Revert a merge commit — need -m flag
# ============================================================
MERGE=$(git log --oneline | grep 'Merge' | awk 'NR==1{print $1}')

echo "=== git revert <merge-commit> without -m FAILS: ==="
git revert --no-edit "$MERGE" 2>&1 || true

echo ""
echo "=== git revert -m 1 <merge-commit> (keep main side): ==="
echo "-m 1 = keep the first parent (main, the branch we merged INTO)"
echo "-m 2 = keep the second parent (feature, the branch we merged FROM)"
git revert --no-edit -m 1 "$MERGE"

echo ""
echo "=== History after merge revert: ==="
git log --oneline --graph

echo ""
echo "=== git revert <merge-commit> requires -m (parent number) ==="
echo "=== -m 1 = keep main, -m 2 = keep the merged branch ==="

cd /tmp
rm -rf "$PLAYGROUND"
