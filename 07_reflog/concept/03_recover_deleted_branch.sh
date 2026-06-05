#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_recover_deleted_branch.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Create a feature branch with important work
# ============================================================
git checkout -b feature 2>/dev/null
echo "Feature work" > feature.txt
git add feature.txt
git commit -m "Feature work" > /dev/null

echo "=== Branches before deletion: ==="
git branch

# Save the commit hash (we'll need it for recovery)
FEATURE_HASH=$(git rev-parse HEAD)

# ============================================================
# 2. Switch to main and delete the branch
# ============================================================
git checkout main 2>/dev/null
git branch -D feature 2>/dev/null

echo ""
echo "=== Branches after deleting feature: ==="
git branch

# ============================================================
# 3. Recover the branch from reflog
#    The branch was HEAD when we committed. Its reflog still exists.
# ============================================================
echo ""
echo "=== Recovering with: git checkout -b recovered $FEATURE_HASH ==="
echo "(The commit still exists in the object database — reflog has the hash)"
git checkout -b recovered "$FEATURE_HASH" 2>/dev/null

echo ""
echo "=== Recovered branch: ==="
git branch
echo "Feature content: $(cat feature.txt)"

echo ""
echo "=== Deleting a branch doesn't delete the commits ==="
echo "=== The reflog keeps them alive for 90 days ==="

cd /tmp
rm -rf "$PLAYGROUND"
