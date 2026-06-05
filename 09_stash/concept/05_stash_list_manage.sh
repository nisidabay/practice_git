#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_stash_list_manage.sh: playground at $PLAYGROUND"

git init
echo "base" > base.txt
git add base.txt
git commit -m "Initial" > /dev/null

# ============================================================
# Build multiple stashes
# ============================================================
echo "change 1" >> base.txt
git stash push -m "First experiment" 2>/dev/null

echo "change 2" >> base.txt
git stash push -m "Second try" 2>/dev/null

echo "change 3" >> base.txt
git stash push -m "Final attempt" 2>/dev/null

# ============================================================
# 1. git stash list
# ============================================================
echo "=== All stashes: ==="
git stash list
echo ""

# ============================================================
# 2. git stash show — what's in a stash?
# ============================================================
echo "=== git stash show stash@{1}: ==="
git stash show stash@{1}
echo ""

# ============================================================
# 3. apply vs pop vs drop
# ============================================================
echo "=== apply = restore but keep in list ==="
echo "=== pop = restore and delete from list ==="
echo "=== drop = delete without restoring ==="
echo ""

echo "=== Dropping stash@{2} (oldest): ==="
git stash drop stash@{2}
echo ""
git stash list

echo ""
echo "=== git stash clear = delete ALL stashes (careful!) ==="

cd /tmp
rm -rf "$PLAYGROUND"
