#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_checkout_vs_restore.sh: playground at $PLAYGROUND"

# ============================================================
# Git 2.23 (Aug 2019) split git checkout into two commands:
#   git switch   — switch branches
#   git restore  — restore files
#
# Before that, git checkout did BOTH. This file shows the old
# and new equivalents so you can read old blog posts.
# ============================================================

git init
echo "Original" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

echo "Edited" >> file.txt
echo "Also edited — staged" >> other.txt
git add other.txt

echo "=== Old way (git checkout) vs New way (git restore): ==="
echo ""
echo "Task: Discard unstaged changes to one file"
echo "  OLD: git checkout -- file.txt"
echo "  NEW: git restore file.txt"
echo ""
echo "Task: Unstage a file"
echo "  OLD: git reset HEAD file.txt"
echo "  NEW: git restore --staged file.txt"
echo ""
echo "Task: Switch branches"
echo "  OLD: git checkout <branch>"
echo "  NEW: git switch <branch>"
echo ""
echo "Task: Create and switch to a new branch"
echo "  OLD: git checkout -b <branch>"
echo "  NEW: git switch -c <branch>"
echo ""
echo "=== If you see 'git checkout --' in old tutorials, ==="
echo "=== mentally replace it with 'git restore'. ==="

cd /tmp
rm -rf "$PLAYGROUND"
