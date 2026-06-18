#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_branch_basics.sh: playground at $PLAYGROUND"

git init
echo "C1" > file.txt
git add file.txt
git commit -m "C1" > /dev/null

# ============================================================
# 1. Create a branch: git branch / git checkout -b / git switch
# ============================================================
echo "=== Current branches: ==="
git branch

git switch -c feature 2>/dev/null

echo ""
echo "=== After git switch -c feature: ==="
git branch
echo "(star = current branch)"

# ============================================================
# 2. Work on the branch
# ============================================================
echo "Feature work" >> file.txt
git add file.txt
git commit -m "Feature commit" > /dev/null

echo ""
echo "=== Log showing diverged history: ==="
git log --oneline --graph --all

echo ""
echo "=== New way (Git 2.23+): ==="
echo "  git switch -c <name>    = create and switch (replaces checkout -b)"
echo "  git switch <name>       = switch to existing branch"
echo "  git branch -d <name>    = delete merged branch"
echo "  git branch -D <name>    = force delete unmerged branch"

cd /tmp
rm -rf "$PLAYGROUND"
