#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_range_diff.sh: playground at $PLAYGROUND"

git init
echo "1" > log.txt
git add log.txt
git commit -m "C1" > /dev/null
echo "2" >> log.txt
git add log.txt
git commit -m "C2" > /dev/null
echo "3" >> log.txt
git add log.txt
git commit -m "C3" > /dev/null
echo "4" >> log.txt
git add log.txt
git commit -m "C4" > /dev/null

# ============================================================
# 1. Diff between two specific commits
# ============================================================
echo "=== All commits: ==="
git log --oneline
echo ""

# Get the first and last commit hashes
FIRST=$(git log --oneline --reverse --max-count=1 | awk '{print $1}')
LAST=$(git log --oneline --max-count=1 | awk '{print $1}')

echo "=== git diff $FIRST..$LAST (C1 vs C4): ==="
git diff "$FIRST..$LAST"

# ============================================================
# 2. Relative references: HEAD~N
# ============================================================
echo ""
echo "=== git diff HEAD~3..HEAD (last 3 commits worth of changes): ==="
git diff HEAD~3..HEAD

echo ""
echo "=== HEAD~1 = one commit back, HEAD~3 = three commits back ==="
echo "=== HEAD~N..HEAD = 'show me what changed in the last N commits' ==="

cd /tmp
rm -rf "$PLAYGROUND"
