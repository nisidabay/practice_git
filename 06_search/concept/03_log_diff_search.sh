#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 03_log_diff_search.sh: playground at $PLAYGROUND"

git init

# ============================================================
# 1. Build history with a regex pattern in patches
# ============================================================
echo "x = 100" > config.py
git add config.py
git commit -m "Add config" > /dev/null

# Edit with your editor — change x and add y
sed -i 's/x = 100/x = 200/' config.py
echo "y = 300" >> config.py
git add config.py
git commit -m "Update config" > /dev/null

# Edit with your editor — change x and replace y with z
sed -i 's/x = 200/x = 400/' config.py
sed -i 's/y = 300/z = 500/' config.py
git add config.py
git commit -m "Final config" > /dev/null

# ============================================================
# 2. -G (pickaxe regex): find commits whose patch matches a regex
#    -S matches the STRING literally in the file content
#    -G matches the REGEX in the patch (added/removed lines)
# ============================================================
echo "=== Commits whose diff contains 'y =': ==="
git log --oneline -G "y ="
echo ""

echo "=== Commits whose diff contains 'z =': ==="
git log --oneline -G "z ="
echo ""

echo "=== Commits whose diff contains 'x = [12]' (regex): ==="
git log --oneline -G "x = [12]"
echo ""

echo "=== -S 'string' = find commits where this exact string count changed ==="
echo "=== -G 'regex'  = find commits whose patch (diff) matches this regex ==="

cd /tmp
rm -rf "$PLAYGROUND"
