#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_stash_partial.sh: playground at $PLAYGROUND"

git init

# Create a file where lines are NOT adjacent — so they become separate hunks
echo "keep this" > app.py
echo "" >> app.py
echo "also keep" >> app.py
echo "" >> app.py
echo "keep too" >> app.py
git add app.py
git commit -m "Initial" > /dev/null

# Now add 2 non-adjacent changes so git sees them as separate hunks
# We'll add line after "keep this" and line after "keep too"
sed -i '2i good change' app.py
sed -i '6i debug print(stuff)' app.py

echo "=== File has both changes (non-adjacent): ==="
cat app.py
echo ""

# ============================================================
# git stash push -p (patch mode) — stash only specific hunks
# ============================================================
# Feed 'n' (don't stash first hunk), then 'y' (stash second hunk)
echo ""
echo "=== Stashing only the debug print (partial stash): ==="
printf "n\ny\n" | git stash push -p -m "debug cruft" 2>/dev/null || true

echo ""
echo "=== After partial stash — only 'good change' remains in working tree: ==="
cat app.py

echo ""
echo "=== Stashed content (debug print is safe in the stash): ==="
git stash show -p 2>/dev/null || echo "(empty stash)"
echo ""

echo "=== git stash push -p = stash only SOME changes ==="
echo "=== Perfect for: 'stash my debug prints, commit the real code' ==="
echo ""
echo "  You choose which hunks to stash:"
echo "    y = stash this hunk"
echo "    n = don't stash this hunk"
echo "    q = quit"

cd /tmp
rm -rf "$PLAYGROUND"
