#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_staged_diff.sh: playground at $PLAYGROUND"

git init
echo "Original" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Modify, then stage — this is what git diff --staged shows
# ============================================================
echo "Line 1" > file.txt
echo "Line 2" >> file.txt
git add file.txt

echo "=== Unstaged diff (empty — we staged everything): ==="
git diff

echo ""
echo "=== Staged diff (index vs HEAD — what will be committed): ==="
git diff --staged

# ============================================================
# 2. Now modify AGAIN without staging
# ============================================================
echo "Line 3 — not staged" >> file.txt

echo ""
echo "=== Unstaged diff NOW shows Line 3: ==="
git diff

echo ""
echo "=== Staged diff still only shows Lines 1-2: ==="
git diff --staged

echo ""
echo "=== The file has 3 lines. Index has 2. HEAD has 1. ==="
echo "=== That's why both diffs show different things. ==="

cd /tmp
rm -rf "$PLAYGROUND"
