#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_merge_conflicts.sh: playground at $PLAYGROUND"

git init
echo "Line 1" > conflict.txt
echo "Line 2" >> conflict.txt
git add conflict.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. Both branches modify the SAME line
# ============================================================
git checkout -b branch 2>/dev/null
echo "Line 1 — from branch" > conflict.txt
echo "Line 2" >> conflict.txt
git add conflict.txt
git commit -m "Branch changes" > /dev/null

git checkout main 2>/dev/null
echo "Line 1 — from main" > conflict.txt
echo "Line 2" >> conflict.txt
git add conflict.txt
git commit -m "Main changes" > /dev/null

# ============================================================
# 2. Merge — CONFLICT!
# ============================================================
echo "=== Merging branch into main — CONFLICT: ==="
git merge branch 2>/dev/null || echo "(conflict expected — merge paused)"
echo ""

echo "=== Conflict markers in conflict.txt: ==="
cat conflict.txt
echo ""

echo "=== Conflict anatomy: ==="
echo "  <<<<<<< HEAD        — YOUR version (current branch)"
echo "  =======             — separator"
echo "  >>>>>>> branch      — THEIR version (incoming branch)"
echo ""

# Abort so script finishes cleanly
git merge --abort 2>/dev/null

echo "=== git merge --abort = bail out, back to clean state ==="
echo "=== To resolve: edit file, remove markers, git add, git commit ==="

cd /tmp
rm -rf "$PLAYGROUND"
