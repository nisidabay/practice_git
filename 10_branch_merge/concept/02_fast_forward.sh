#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_fast_forward.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. Create feature branch, add commits
# ============================================================
git checkout -b feature 2>/dev/null
echo "Feature A" >> base.txt
git add base.txt
git commit -m "Feature A" > /dev/null

echo "Feature B" >> base.txt
git add base.txt
git commit -m "Feature B" > /dev/null

echo "=== Before merge: ==="
git log --oneline --graph --all
echo ""

# ============================================================
# 2. Merge back to main — FAST-FORWARD
#    main has NO new commits since the branch split,
#    so Git just moves the main pointer forward.
# ============================================================
git checkout main 2>/dev/null
git merge feature

echo ""
echo "=== After fast-forward merge: ==="
git log --oneline --graph --all

echo ""
echo "=== Fast-forward = main just 'caught up' to feature ==="
echo "=== No merge commit created. History is a straight line. ==="

cd /tmp
rm -rf "$PLAYGROUND"
