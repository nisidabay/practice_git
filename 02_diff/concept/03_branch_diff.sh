#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_branch_diff.sh: playground at $PLAYGROUND"

git init
echo "Version 1" > shared.txt
git add shared.txt
git commit -m "Initial" > /dev/null

# ============================================================
# 1. Create a feature branch with its own changes
# ============================================================
git checkout -b feature 2>/dev/null
echo "Feature work" > feature.txt
git add feature.txt
git commit -m "Add feature file" > /dev/null
echo "More feature" >> feature.txt
git add feature.txt
git commit -m "Extend feature" > /dev/null

# ============================================================
# 2. Go back to main
# ============================================================
git checkout main 2>/dev/null

# ============================================================
# 3. Diff two branches: git diff main..feature
# ============================================================
echo "=== git diff main..feature — what feature has that main doesn't: ==="
git diff main..feature

echo ""
echo "=== You can also use: git diff main...feature ==="
echo "=== (three dots = changes since they diverged, ignoring shared history) ==="

cd /tmp
rm -rf "$PLAYGROUND"
