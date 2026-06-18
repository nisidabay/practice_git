#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_git_blame.sh: playground at $PLAYGROUND"

git init

# ============================================================
# 1. Build a file written by multiple "authors" over time
# ============================================================
echo "line 1 — original" > shared.py
git add shared.py
git commit -m "Initial shared file" > /dev/null

echo "line 2 — added later" >> shared.py
git add shared.py
git commit -m "Add line 2" > /dev/null

sed -i 's/line 1 — original/line 3 — changed line 1/' shared.py
git add shared.py
git commit -m "Rewrite line 1" > /dev/null

# ============================================================
# 2. git blame — who wrote each line?
# ============================================================
echo "=== git blame shared.py: ==="
git blame shared.py
echo ""

# ============================================================
# 3. git blame with line range: -L
# ============================================================
echo "=== git blame -L2,2 shared.py (only line 2): ==="
git blame -L2,2 shared.py
echo ""

# ============================================================
# 4. git blame --since (ignore older commits)
# ============================================================
echo "=== git blame --since='HEAD~2' shared.py (only recent commits): ==="
git blame --since="HEAD~2" shared.py
echo ""

echo "=== git blame = 'for each line, which commit last touched it?' ==="
echo "=== ^abc123 = the line hasn't changed since that commit ==="
echo "=== -L <start>,<end> = only blame a range of lines ==="

cd /tmp
rm -rf "$PLAYGROUND"
