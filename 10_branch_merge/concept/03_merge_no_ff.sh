#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_merge_no_ff.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. BOTH branches get new commits (not a fast-forward case)
# ============================================================
git checkout -b feature 2>/dev/null
echo "Feature work" > feature.txt
git add feature.txt
git commit -m "Feature work" > /dev/null

git checkout main 2>/dev/null
echo "Main work" > main.txt
git add main.txt
git commit -m "Main work" > /dev/null

# ============================================================
# 2. Merge --no-ff — CREATE A MERGE COMMIT explicitly
# ============================================================
echo "=== Before merge (both branches diverged): ==="
git log --oneline --graph --all
echo ""

git merge --no-ff feature -m "Merge feature into main"

echo ""
echo "=== After merge --no-ff: ==="
git log --oneline --graph --all

echo ""
echo "=== --no-ff = create a merge commit even if fast-forward is possible ==="
echo "=== This preserves the branch structure in history ==="
echo "=== Use --no-ff when you want to see 'a branch was merged here' ==="

cd /tmp
rm -rf "$PLAYGROUND"
