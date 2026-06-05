#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_word_diff.sh: playground at $PLAYGROUND"

git init
echo "The quick brown fox jumps over the lazy dog" > text.txt
git add text.txt
git commit -m "Initial" > /dev/null

# ============================================================
# 1. Normal diff — shows ENTIRE line as changed
# ============================================================
echo "The quick red fox jumps over the lazy dog" > text.txt

echo "=== Default diff (line-level): ==="
git diff

# ============================================================
# 2. --word-diff — shows WHICH WORD changed
# ============================================================
echo ""
echo "=== git diff --word-diff (word-level): ==="
git diff --word-diff

# ============================================================
# 3. --color-words — highlights only changed words inline
# ============================================================
echo ""
echo "=== git diff --color-words: ==="
git diff --color-words

echo ""
echo "=== --word-diff highlights exactly WHAT changed within a line ==="
echo "=== --color-words is compact: one line per changed line ==="

cd /tmp
rm -rf "$PLAYGROUND"
