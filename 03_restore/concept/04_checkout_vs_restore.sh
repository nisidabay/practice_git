#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_checkout_vs_restore.sh: playground at $PLAYGROUND"

# ============================================================
# Git 2.23 (Aug 2019) split git checkout into two commands:
#   git switch   — switch branches
#   git restore  — restore files
#
# Before that, git checkout did BOTH. This file shows the old
# and new equivalents side by side.
# ============================================================

git init
echo "Original" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Old way: git checkout -- <file>  →  git restore <file>
# ============================================================
echo "Editing file for demo..." >> file.txt

echo ""
echo "=== Task: Discard unstaged changes (working tree → index) ==="
echo "  OLD: git checkout -- file.txt"
git checkout -- file.txt 2>/dev/null
echo "  Content after checkout --: $(cat file.txt)"
echo ""

# Re-create the change to demo restore
echo "Editing file for demo..." >> file.txt
echo "  NEW: git restore file.txt"
git restore file.txt
echo "  Content after restore: $(cat file.txt)"

# ============================================================
# 2. Old way: git reset HEAD <file>  →  git restore --staged <file>
# ============================================================
echo "Line to stage" >> file.txt
git add file.txt

echo ""
echo "=== Task: Unstage a file (index → HEAD) ==="
echo "  OLD: git reset HEAD file.txt"
git reset HEAD file.txt 2>/dev/null
echo "  (staged diff empty? check...)"
git diff --staged | head -2 || echo "  (empty — unstaged correctly)"

echo "  NEW: git restore --staged file.txt"
echo "Line to stage" >> file.txt
git add file.txt
git restore --staged file.txt
echo "  (staged diff empty? check...)"
git diff --staged | head -2 || echo "  (empty — unstaged correctly)"

# ============================================================
# 3. Old way: git checkout <branch>  →  git switch <branch>
# ============================================================
git add file.txt
git commit -m "Commit before switching" > /dev/null
git branch demo-branch

echo ""
echo "=== Task: Switch branches ==="
echo "  OLD: git checkout demo-branch   (then back)"
git checkout demo-branch 2>/dev/null
echo "  Current branch: $(git branch --show-current)"
git checkout main 2>/dev/null

echo "  NEW: git switch demo-branch"
git switch demo-branch 2>/dev/null
echo "  Current branch: $(git branch --show-current)"

# ============================================================
# 4. Old way: git checkout -b <branch>  →  git switch -c <branch>
# ============================================================
git switch main 2>/dev/null
echo ""
echo "=== Task: Create and switch to a new branch ==="
echo "  OLD: git checkout -b new-feature"
git checkout -b new-feature 2>/dev/null
echo "  Current branch: $(git branch --show-current)"

git switch main 2>/dev/null
echo "  NEW: git switch -c another-feature"
git switch -c another-feature 2>/dev/null
echo "  Current branch: $(git branch --show-current)"

echo ""
echo "=== If you see 'git checkout --' in old tutorials, ==="
echo "=== mentally replace it with 'git restore'. ==="
echo "=== If you see 'git checkout <branch>', use 'git switch'. ==="

cd /tmp
rm -rf "$PLAYGROUND"
