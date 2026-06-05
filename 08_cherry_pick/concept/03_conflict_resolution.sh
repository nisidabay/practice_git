#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_conflict_resolution.sh: playground at $PLAYGROUND"

git init

# ============================================================
# 1. Create a file on main
# ============================================================
echo "Line 1" > conflict.txt
echo "Line 2" >> conflict.txt
git add conflict.txt
git commit -m "Base" > /dev/null

# ============================================================
# 2. Create a branch that edits Line 1
# ============================================================
git checkout -b side 2>/dev/null
echo "Line 1 — from side branch" > conflict.txt
echo "Line 2" >> conflict.txt
git add conflict.txt
git commit -m "Side change to line 1" > /dev/null
SIDE_HASH=$(git rev-parse HEAD)

# ============================================================
# 3. On main, also edit Line 1 — creating a conflict
# ============================================================
git checkout main 2>/dev/null
echo "Line 1 — from main branch" > conflict.txt
echo "Line 2" >> conflict.txt
git add conflict.txt
git commit -m "Main change to line 1" > /dev/null

# ============================================================
# 4. Cherry-pick the side commit — CONFLICT
# ============================================================
echo "=== Cherry-picking side commit (will conflict): ==="
git cherry-pick "$SIDE_HASH" 2>/dev/null || echo "(conflict expected — cherry-pick paused)"
echo ""

echo "=== Conflict markers in conflict.txt: ==="
cat conflict.txt
echo ""

echo "=== Resolve the conflict by editing the file, then: ==="
echo "===   git add conflict.txt"
echo "===   git cherry-pick --continue"
echo "==="
echo "=== Or abort: ==="
echo "===   git cherry-pick --abort"

# Abort so the script finishes cleanly
git cherry-pick --abort 2>/dev/null

cd /tmp
rm -rf "$PLAYGROUND"
