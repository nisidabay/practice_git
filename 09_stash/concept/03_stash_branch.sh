#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_stash_branch.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Build up a meaningful stash of work
# ============================================================
echo "feature part 1" > feature.txt
echo "feature part 2" >> feature.txt
git add feature.txt
git stash push -u -m "Feature work so far"
echo "stashed"

# ============================================================
# 2. git stash branch — recover a stash as a BRANCH
# ============================================================
echo ""
echo "=== git stash branch recovered-feature stash@{0}: ==="
echo "(This creates a new branch from where the stash was made,"
echo " then pops the stash onto it.)"
git stash branch recovered-feature stash@{0} 2>/dev/null

echo ""
echo "=== Now on branch 'recovered-feature': ==="
git branch
echo ""
echo "=== The stashed changes are applied: ==="
cat feature.txt

echo ""
echo "=== stash branch = 'I should have made a branch before this work' ==="
echo "=== Best recovery when you realize mid-work it needs its own branch ==="

cd /tmp
rm -rf "$PLAYGROUND"
