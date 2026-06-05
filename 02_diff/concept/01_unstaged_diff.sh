#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_unstaged_diff.sh: playground at $PLAYGROUND"

git init
echo "Line 1" > file.txt
git add file.txt
git commit -m "First commit" > /dev/null

# ============================================================
# git diff — working tree vs index (staging area)
# ============================================================

# Modify the file without staging
echo "Line 1" > file.txt
echo "Line 2 — added now" >> file.txt
echo "Line 3 — also new" >> file.txt

# This shows what you changed but haven't staged yet
# The diff header shows 'a/file.txt' (index version) vs 'b/file.txt' (working tree)
git diff

echo ""
echo "=== git diff shows: working tree ≠ index ==="
echo "=== Lines starting with + are NEW (in working tree but not in index) ==="
echo "=== Lines starting with - are GONE (in index but not in working tree) ==="

cd /tmp
rm -rf "$PLAYGROUND"
