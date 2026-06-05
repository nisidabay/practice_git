#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_signoff_flag.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Base" > /dev/null

# ============================================================
# 1. Create a fix on a branch
# ============================================================
git checkout -b hotfix 2>/dev/null
echo "Patch: fix buffer overflow" > patch.c
git add patch.c
git commit -m "Fix buffer overflow in parser" > /dev/null
FIX_HASH=$(git rev-parse HEAD)

echo "=== Commit on hotfix: ==="
git log --oneline -1

# ============================================================
# 2. Cherry-pick WITHOUT -x (no origin record)
# ============================================================
git checkout main 2>/dev/null
git cherry-pick "$FIX_HASH" 2>/dev/null

echo ""
echo "=== Without -x — message looks like original but no origin trace: ==="
git log --oneline -1
git log -1 --format="%B"

# ============================================================
# 3. Cherry-pick WITH -x (records origin)
# ============================================================
echo ""
echo "=== With -x, the commit message gets: ==="
echo "===   (cherry picked from commit $FIX_HASH)"
echo ""
echo "Always use: git cherry-pick -x <hash>"
echo "This leaves a breadcrumb back to the original commit."
echo "Six months from now, you'll know WHERE this came from."

cd /tmp
rm -rf "$PLAYGROUND"
