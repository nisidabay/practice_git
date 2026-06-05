#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_restore_from_commit.sh: playground at $PLAYGROUND"

git init
echo "Version 1" > file.txt
git add file.txt
git commit -m "V1" > /dev/null

echo "Version 2 — changed" > file.txt
git add file.txt
git commit -m "V2" > /dev/null

echo "Version 3 — current" > file.txt
git add file.txt
git commit -m "V3" > /dev/null

# ============================================================
# 1. Current content
# ============================================================
echo "=== Current file.txt: ==="
cat file.txt

# ============================================================
# 2. Restore from a specific commit — git restore --source
# ============================================================
FIRST_COMMIT=$(git log --oneline --reverse --max-count=1 | awk '{print $1}')

echo ""
echo "=== Restoring file.txt to its V1 state (commit $FIRST_COMMIT): ==="
git restore --source="$FIRST_COMMIT" file.txt

echo ""
echo "=== file.txt after restore: ==="
cat file.txt

echo ""
echo "=== Note: this is UNSTAGED — you can commit it or discard it ==="
echo "=== git restore --source=<commit> <file> = time-travel one file ==="

cd /tmp
rm -rf "$PLAYGROUND"
