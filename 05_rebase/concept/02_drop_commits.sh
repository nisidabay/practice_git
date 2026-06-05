#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_drop_commits.sh: playground at $PLAYGROUND"

git init

echo "base" > README.md
git add README.md
git commit -m "Initial base" > /dev/null

echo "good 1" > good1.txt
git add good1.txt
git commit -m "Add good1" > /dev/null

echo "secret=password123" > secrets.txt
git add secrets.txt
git commit -m "Oops: added secrets" > /dev/null

echo "good 2" > good2.txt
git add good2.txt
git commit -m "Add good2" > /dev/null

echo "good 3" > good3.txt
git add good3.txt
git commit -m "Add good3" > /dev/null

echo "=== Before drop — 4 commits, including secrets: ==="
git log --oneline
ls
echo ""

# ============================================================
# 1. Drop the secrets commit — GIT_SEQUENCE_EDITOR replaces pick with drop
# ============================================================
GIT_SEQUENCE_EDITOR="sed -i '/secrets/s/^pick/drop/'" GIT_EDITOR=true \
git rebase -i HEAD~4

echo "=== After drop — 3 commits, secrets gone: ==="
git log --oneline
echo ""
echo "=== secrets.txt does not exist: ==="
ls
echo ""

echo "=== drop = delete a commit entirely from history ==="
echo "=== The file it introduced is also gone. ==="

cd /tmp
rm -rf "$PLAYGROUND"
