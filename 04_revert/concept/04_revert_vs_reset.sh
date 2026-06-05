#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_revert_vs_reset.sh: playground at $PLAYGROUND"

git init
echo "C1" >> log.txt
git add log.txt
git commit -m "C1" > /dev/null
echo "C2" >> log.txt
git add log.txt
git commit -m "C2" > /dev/null
echo "C3" >> log.txt
git add log.txt
git commit -m "C3" > /dev/null

echo "=== Decide: revert or reset? ==="
echo ""

echo "REVERT (safe, always use for published commits):"
echo "  - Creates a NEW commit that undoes an old one"
echo "  - History grows — git revert <commit>"
echo "  - Other people can pull your revert safely"
echo "  - Works on any commit, even the oldest one"
echo ""

echo "RESET (destructive, only for local/unpushed commits):"
echo "  - Moves the branch pointer backward"
echo "  - Commits are GONE (git reset --hard HEAD~1)"
echo "  - If already pushed, other people will hate you"
echo "  - Good for: 'I just committed to the wrong branch'"
echo ""

echo "=== Rule of thumb: ==="
echo "  Pushed?       → git revert"
echo "  Not pushed?   → git reset"
echo "  Unsure?       → git revert (you can always undo a revert)"

cd /tmp
rm -rf "$PLAYGROUND"
