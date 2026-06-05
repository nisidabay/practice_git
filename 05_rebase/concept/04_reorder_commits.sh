#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_reorder_commits.sh: playground at $PLAYGROUND"

git init

echo "base" > README.md
git add README.md
git commit -m "Initial base" > /dev/null

# ============================================================
# 1. Create independent commits (each touches a different file)
#    Independent = safe to reorder
# ============================================================
echo "Feature A" > feature-a.txt
git add feature-a.txt
git commit -m "Add feature A" > /dev/null

echo "Feature B" > feature-b.txt
git add feature-b.txt
git commit -m "Add feature B" > /dev/null

echo "Feature C" > feature-c.txt
git add feature-c.txt
git commit -m "Add feature C" > /dev/null

echo "=== Before reorder — A, B, C: ==="
git log --oneline
echo ""

# ============================================================
# 2. Reorder: we want C to come before B
#    In the rebase todo list, the order IS the order.
#    Swap line 2 and line 3.
# ============================================================
GIT_SEQUENCE_EDITOR="sed -i '2{h;d}; 3{G}'" GIT_EDITOR=true \
git rebase -i HEAD~3

echo "=== After reorder — A, C, B: ==="
git log --oneline

echo ""
echo "=== Each file still has the right content: ==="
cat feature-a.txt feature-b.txt feature-c.txt

echo ""
echo "=== reorder works when commits are INDEPENDENT ==="
echo "=== (each commit touches a different file) ==="
echo "=== If commits modify the same lines, reordering causes conflicts ==="

cd /tmp
rm -rf "$PLAYGROUND"
