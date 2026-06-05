#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_stash_push_pop.sh: playground at $PLAYGROUND"

git init
echo "baseline" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Start working on something
# ============================================================
echo "work in progress" >> file.txt
echo "also editing this" > other.txt
git add other.txt

echo "=== Working tree is dirty: ==="
git status --short
echo ""

# ============================================================
# 2. Stash it — save the changes and clean the working tree
# ============================================================
git stash push -m "WIP: half-done feature"
echo "=== After git stash: ==="
git status --short
echo "(clean! Ready to switch branches)"
echo ""

# ============================================================
# 3. Do something else (simulate switching context)
# ============================================================
git checkout -b hotfix 2>/dev/null
echo "EMERGENCY FIX" > hotfix.txt
git add hotfix.txt
git commit -m "Emergency hotfix" > /dev/null
git checkout main 2>/dev/null

# ============================================================
# 4. Pop the stash — get your work back
# ============================================================
echo "=== git stash pop — restoring saved work: ==="
git stash pop 2>/dev/null

echo ""
echo "=== Working tree is dirty again — exactly as you left it: ==="
git status --short
cat file.txt

echo ""
echo "=== git stash = save dirty state, get clean working tree ==="
echo "=== git stash pop = restore and delete the stash entry ==="

cd /tmp
rm -rf "$PLAYGROUND"
