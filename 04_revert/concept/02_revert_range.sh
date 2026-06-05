#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_revert_range.sh: playground at $PLAYGROUND"

git init

echo "good" > good1.txt
git add good1.txt
git commit -m "C1 good" > /dev/null

echo "bad" > bad2.txt
git add bad2.txt
git commit -m "C2 bad" > /dev/null

echo "bad" > bad3.txt
git add bad3.txt
git commit -m "C3 bad" > /dev/null

echo "good" > good4.txt
git add good4.txt
git commit -m "C4 good" > /dev/null

echo "=== Files before revert: ==="
ls *.txt
echo ""

# ============================================================
# 1. Revert a RANGE — git revert OLDEST..NEWEST
#    This reverts C2 and C3 (everything AFTER C1 up to C3)
# ============================================================
OLDEST=$(git log --oneline --reverse | awk '/C2/{print $1}')
NEWEST=$(git log --oneline --reverse | awk '/C3/{print $1}')

echo ""
echo "=== Reverting range $OLDEST..$NEWEST (C2 through C3): ==="
echo ""
echo "Note: git revert creates one revert commit PER reverted commit"
git revert --no-edit "$OLDEST..$NEWEST"

echo ""
echo "=== History after range revert: ==="
git log --oneline

echo ""
echo "=== Files after revert — bad2.txt and bad3.txt gone: ==="
ls *.txt

echo ""
echo "=== Range revert = git revert OLDEST..NEWEST ==="
echo "=== Creates one revert commit per commit in the range ==="

cd /tmp
rm -rf "$PLAYGROUND"
