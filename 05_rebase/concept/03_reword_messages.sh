#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_reword_messages.sh: playground at $PLAYGROUND"

git init

echo "base" > README.md
git add README.md
git commit -m "Initial base" > /dev/null

echo "data" > data.txt
git add data.txt
git commit -m "stuff" > /dev/null

echo "more" >> data.txt
git add data.txt
git commit -m "updates" > /dev/null

echo "=== Before reword — bad messages: ==="
git log --oneline
echo ""

# ============================================================
# 1. Reword the first commit only
#    GIT_SEQUENCE_EDITOR sets the todo list (pick→reword)
#    GIT_EDITOR rewrites the commit message inline
# ============================================================
GIT_SEQUENCE_EDITOR="sed -i '1s/^pick/reword/'" \
GIT_EDITOR="sed -i '1s/.*/Add initial data file/'" \
git rebase -i HEAD~2

echo ""
echo "=== After reword: ==="
git log --oneline

echo ""
echo "=== reword = change the commit message without changing the code ==="
echo "=== GIT_SEQUENCE_EDITOR swaps 'pick' → 'reword' ==="
echo "=== GIT_EDITOR rewrites the message ==="

cd /tmp
rm -rf "$PLAYGROUND"
