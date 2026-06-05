#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_single_pick.sh: playground at $PLAYGROUND"

git init
echo "main work" > main.txt
git add main.txt
git commit -m "Main base" > /dev/null

# ============================================================
# 1. Create a branch with a specific fix
# ============================================================
git checkout -b feature 2>/dev/null
echo "Bug fix applied" > fix.txt
git add fix.txt
git commit -m "Fix critical bug" > /dev/null

# Get the hash of the fix commit
FIX_HASH=$(git rev-parse HEAD)

# ============================================================
# 2. Switch back to main and cherry-pick just that commit
# ============================================================
git checkout main 2>/dev/null

echo "=== Before cherry-pick — main only has main.txt: ==="
ls
echo ""

echo "=== Cherry-picking $FIX_HASH: ==="
git cherry-pick "$FIX_HASH" 2>/dev/null

echo ""
echo "=== After cherry-pick — fix.txt now exists on main: ==="
ls
echo ""
echo "=== History on main: ==="
git log --oneline
echo ""

echo "=== cherry-pick = grab ONE commit from a branch without merging everything ==="
echo "=== It creates a NEW commit with the same changes but a different hash ==="

cd /tmp
rm -rf "$PLAYGROUND"
