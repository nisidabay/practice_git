#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_multiple_picks.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. Feature branch with 3 commits
# ============================================================
git checkout -b feature 2>/dev/null
echo "A" > a.txt; git add a.txt; git commit -m "Add A" > /dev/null
echo "B" > b.txt; git add b.txt; git commit -m "Add B" > /dev/null
echo "C" > c.txt; git add c.txt; git commit -m "Add C" > /dev/null

C_HASH=$(git rev-parse HEAD~0)  # newest
A_HASH=$(git rev-parse HEAD~2)  # oldest

# ============================================================
# 2. Cherry-pick a RANGE: A..C = A (exclusive) through C (inclusive)
# ============================================================
git checkout main 2>/dev/null

echo "=== Cherry-picking range $A_HASH..$C_HASH: ==="
git cherry-pick "$A_HASH..$C_HASH" 2>/dev/null

echo ""
echo "=== All three changes are now on main: ==="
ls *.txt
git log --oneline

echo ""
echo "=== A..B = commits AFTER A up to and including B ==="
echo "=== To include A itself, use A^..B ==="

cd /tmp
rm -rf "$PLAYGROUND"
