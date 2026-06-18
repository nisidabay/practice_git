#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_squash_commits.sh: playground at $PLAYGROUND"

git init

# Base commit so HEAD~4 has an ancestor to rebase against
echo "base" > README.md
git add README.md
git commit -m "Initial base" > /dev/null

# ============================================================
# 1. Make messy commits — WIP, fixup, typo fixes
# ============================================================
echo "Part 1" > feature.txt
git add feature.txt
git commit -m "WIP: started feature" > /dev/null

echo "Part 2" >> feature.txt
git add feature.txt
git commit -m "fix typo" > /dev/null

echo "Part 3" >> feature.txt
git add feature.txt
git commit -m "actually working now" > /dev/null

echo "Part 4" >> feature.txt
git add feature.txt
git commit -m "final version" > /dev/null

echo "=== Before squash — 4 messy commits: ==="
git log --oneline
echo ""

# ============================================================
# 2. Interactive rebase: pick first, squash rest
#    GIT_SEQUENCE_EDITOR replaces the interactive editor
# ============================================================
GIT_SEQUENCE_EDITOR="sed -i '2,\$s/^pick/squash/'" GIT_EDITOR=true \
git rebase -i HEAD~4

echo "=== After squash — 1 clean commit: ==="
git log --oneline

echo ""
echo "=== feature.txt has all 4 parts: ==="
cat feature.txt

echo ""
echo "=== squash = combine many WIP commits into one clean one ==="
echo "=== The first commit stays 'pick', rest become 'squash' ==="
cd /tmp
rm -rf "$PLAYGROUND"
