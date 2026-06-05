#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_recover_reset.sh: playground at $PLAYGROUND"

git init
echo "Important work" > important.txt
git add important.txt
git commit -m "Important commit" > /dev/null

echo "More important" >> important.txt
git add important.txt
git commit -m "Another important" > /dev/null

echo "=== Before reset — 2 commits: ==="
git log --oneline

# ============================================================
# 1. Oops — hard reset (destroys the second commit)
# ============================================================
git reset --hard HEAD~1 2>/dev/null

echo ""
echo "=== After git reset --hard HEAD~1: ==="
git log --oneline
echo "(the second commit appears gone!)"
echo ""

# ============================================================
# 2. Recover via reflog
# ============================================================
echo "=== git reflog: ==="
git reflog | head -10
echo ""

# The reset created a reflog entry. The commit BEFORE that entry is our lost commit.
# HEAD@{1} is the state before the reset.
echo "=== Recovering with: git reset HEAD@{1} ==="
git reset HEAD@{1} 2>/dev/null

echo ""
echo "=== After recovery: ==="
git log --oneline

echo ""
echo "=== git reset HEAD@{N} = time-travel through the reflog ==="
echo "=== reflog is your safety net. It remembers for 90 days by default. ==="

cd /tmp
rm -rf "$PLAYGROUND"
