#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_stash_partial.sh: playground at $PLAYGROUND"

git init
echo "line 1" > app.py
echo "line 2" >> app.py
git add app.py
git commit -m "Initial" > /dev/null

echo "good change" >> app.py
echo "debug print(stuff)" >> app.py

echo "=== File has both changes: ==="
cat app.py
echo ""

# ============================================================
# git stash push -p (patch mode) — stash only specific hunks
# ============================================================
echo "=== git stash push -p = stash only SOME changes ==="
echo "=== You choose which hunks to stash interactively ==="
echo "=== Not runnable non-interactively — here's the concept: ==="
echo ""
echo "  git stash push -p"
echo ""
echo "  Git shows each hunk:"
echo "  Stash this hunk [y,n,q,a,d,e,?]?"
echo ""
echo "  y = stash this hunk"
echo "  n = don't stash this hunk"
echo "  q = quit"
echo "  ? = help"
echo ""
echo "=== After partial stash, some changes are stashed, some remain ==="
echo "=== Perfect for: 'stash my debug prints, commit the real code' ==="

cd /tmp
rm -rf "$PLAYGROUND"
