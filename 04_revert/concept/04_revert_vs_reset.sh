#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_revert_vs_reset.sh: playground at $PLAYGROUND"

git init

# Use separate files per commit to avoid merge conflicts in revert
echo "C1" > c1.txt
git add c1.txt
git commit -m "C1" > /dev/null
echo "C2" > c2.txt
git add c2.txt
git commit -m "C2" > /dev/null
echo "C3" > c3.txt
git add c3.txt
git commit -m "C3" > /dev/null

echo ""
echo "=== Before any undo — 3 commits, 3 files: ==="
ls *.txt
git log --oneline

# ============================================================
# 1. git revert — safe, even for published commits
# ============================================================
C2_HASH=$(git log --oneline | awk '/C2/{print $1}')
echo ""
echo "=== git revert $C2_HASH (C2) — creates a NEW commit: ==="
git revert --no-edit "$C2_HASH"
echo ""
echo "History after revert — C2 undone but C2 commit still in history:"
git log --oneline
echo ""
echo "Files after revert — c2.txt is gone:"
ls *.txt

# Reset for demo #2
echo ""
echo "=== Now resetting for the RESET demo... ==="
git reset --hard HEAD~1 2>/dev/null

# ============================================================
# 2. git reset — destructive, only for local commits
# ============================================================
echo ""
echo "=== git reset --hard HEAD~2 — moves branch pointer back: ==="
git reset --hard HEAD~2 2>/dev/null
echo ""
echo "History after reset — C2 and C3 are GONE:"
git log --oneline
echo ""
echo "Files after reset — only c1.txt remains:"
ls *.txt

echo ""
echo "=== Rule of thumb: ==="
echo "  Pushed?       → git revert"
echo "  Not pushed?   → git reset"
echo "  Unsure?       → git revert (you can always undo a revert)"
echo ""
echo "=== REVERT (safe): Creates a NEW commit that undoes an old one ==="
echo "=== RESET (destructive): Moves branch pointer backward ==="

cd /tmp
rm -rf "$PLAYGROUND"
