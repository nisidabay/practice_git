#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_stash_untracked.sh: playground at $PLAYGROUND"

git init
echo "committed" > tracked.txt
git add tracked.txt
git commit -m "Initial" > /dev/null

# ============================================================
# 1. Create an untracked file + modify a tracked file
# ============================================================
echo "new untracked file" > new-file.txt
echo "modified tracked" >> tracked.txt

echo "=== Before stash: ==="
git status --short
echo "(new-file.txt is untracked)"
echo ""

# ============================================================
# 2. git stash WITHOUT -u — untracked file stays
# ============================================================
git stash push -m "only tracked" 2>/dev/null
echo "=== After stash (no -u) — new-file.txt is STILL here: ==="
ls -1
echo ""

# ============================================================
# 3. git stash -u (--include-untracked) — cleans everything
# ============================================================
git stash pop 2>/dev/null  # get our work back
echo "modified tracked" >> tracked.txt
echo "another new" > another-new.txt

git stash push -u -m "everything including untracked"
echo "=== After stash -u — everything clean: ==="
ls -1
echo "(only tracked.txt remains — untracked files are stashed too)"
echo ""

echo "=== git stash -u = stash tracked + untracked files ==="
echo "=== Without -u, only tracked/staged changes are stashed ==="

cd /tmp
rm -rf "$PLAYGROUND"
