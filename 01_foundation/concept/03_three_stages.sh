#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_three_stages.sh: playground at $PLAYGROUND"

git init
echo "Version 1" > file.txt
git add file.txt
git commit -m "First commit" > /dev/null

# ============================================================
# The Three Stages: Working Tree → Index → HEAD
#
#   working tree          index              HEAD
#   (your files)     (git add →)        (commit →)
#       file.txt  ─────→  staged file.txt  ─────→  committed
# ============================================================

# ============================================================
# 1. Modify working tree. Index and HEAD still have Version 1.
# ============================================================
echo "Version 2" >> file.txt

echo "=== Working tree changed ==="
git diff              # working tree vs index

echo "=== Index still matches HEAD ==="
git diff --staged     # index vs HEAD (empty — nothing staged)

# ============================================================
# 2. Stage the change. Index gets Version 2. HEAD still Version 1.
# ============================================================
git add file.txt

echo "=== Working tree matches index (no unstaged diff) ==="
git diff              # empty

echo "=== Index differs from HEAD ==="
git diff --staged     # shows what will be committed

# ============================================================
# 3. Commit. Now HEAD matches index.
# ============================================================
git commit -m "Second commit" > /dev/null

echo "=== Everything clean — all three in sync ==="
git diff              # empty
git diff --staged     # empty
git status

cd /tmp
rm -rf "$PLAYGROUND"
