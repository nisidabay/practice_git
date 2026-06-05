#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_unstage_files.sh: playground at $PLAYGROUND"

git init
echo "Original" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. Add a file you don't want to commit yet
# ============================================================
echo "Unwanted staged content" >> file.txt
git add file.txt

echo "=== file.txt is staged: ==="
git diff --staged

# ============================================================
# 2. git restore --staged — move it back to working tree
# ============================================================
git restore --staged file.txt

echo ""
echo "=== After restore --staged — no longer staged: ==="
git diff --staged

echo ""
echo "=== But the change still exists in working tree: ==="
git diff

echo ""
echo "=== --staged only touches the index — working tree untouched ==="
echo "=== Your edit is still there, just not staged anymore. ==="

cd /tmp
rm -rf "$PLAYGROUND"
