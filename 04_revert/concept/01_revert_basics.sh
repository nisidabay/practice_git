#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_revert_basics.sh: playground at $PLAYGROUND"

git init

# ============================================================
# 1. Build a small history
# ============================================================
echo "File 1" > file1.txt
git add file1.txt
git commit -m "Add file1.txt" > /dev/null

echo "File 2" > file2.txt
git add file2.txt
git commit -m "Add file2" > /dev/null

echo "BUG: broken code" > bug.txt
git add bug.txt
git commit -m "Add bug.txt (buggy)" > /dev/null

echo "File 4" > file4.txt
git add file4.txt
git commit -m "Add file4" > /dev/null

echo "=== History before revert: ==="
git log --oneline
echo ""

# ============================================================
# 2. git revert — undo a commit by creating a NEW commit
# ============================================================
# Vanilla git:
BUGGY=$(git log --format=%H --grep='buggy' --max-count=1)
# Pipe con grep+awk:
BUGGY=$(git log --oneline | grep 'buggy' | awk '{print $1}')
echo "=== Reverting $BUGGY (the buggy commit): ==="
git revert --no-edit "$BUGGY"

echo ""
echo "=== History after revert — notice NEW commit, old still there: ==="
git log --oneline

echo ""
echo "=== After revert — bug.txt is gone (check with ls): ==="
ls *.txt

echo ""
echo "=== git revert creates a NEW commit that undoes an old one ==="
echo "=== Safe to use on published commits. History is append-only. ==="

cd /tmp
rm -rf "$PLAYGROUND"
