#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_reflog_basics.sh: playground at $PLAYGROUND"

git init
echo "C1" > file.txt; git add file.txt; git commit -m "C1" > /dev/null
echo "C2" >> file.txt; git add file.txt; git commit -m "C2" > /dev/null
echo "C3" >> file.txt; git add file.txt; git commit -m "C3" > /dev/null

# ============================================================
# 1. git log — shows commit history
# ============================================================
echo "=== git log (the DAG): ==="
git log --oneline

# ============================================================
# 2. git reflog — shows EVERYTHING you did
# ============================================================
echo ""
echo "=== git reflog (the audit trail): ==="
git reflog | head -10

echo ""
echo "=== reflog records every time HEAD moved: ==="
echo "=== commits, checkouts, resets, rebases, amends — everything ==="
echo "=== HEAD@{0} is NOW, HEAD@{1} is one move ago, etc. ==="

cd /tmp
rm -rf "$PLAYGROUND"
