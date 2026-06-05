#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_discard_unstaged.sh: playground at $PLAYGROUND"

git init
echo "Original content" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Make a change you regret
# ============================================================
echo "Bad idea — delete this" >> file.txt
echo "Line 1" > other.txt
echo "Line 2" >> other.txt
git add other.txt
git commit -m "Add other.txt" > /dev/null
echo "Bad line in other" >> other.txt

echo "=== Current state — both files modified: ==="
git status

# ============================================================
# 2. git restore — revert working tree to match the index
# ============================================================
echo ""
echo "=== Discarding unstaged changes in file.txt: ==="
git restore file.txt

echo ""
echo "=== file.txt after restore: ==="
cat file.txt

echo ""
echo "=== git restore <file> = 'take the file back to its staged state' ==="
echo "=== If it's not staged, it goes back to HEAD. ==="

cd /tmp
rm -rf "$PLAYGROUND"
