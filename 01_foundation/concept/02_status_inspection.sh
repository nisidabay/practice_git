#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_status_inspection.sh: playground at $PLAYGROUND"

git init
echo "First line" > file.txt
git add file.txt
git commit -m "Initial commit" > /dev/null

# ============================================================
# 1. git status — clean working tree
# ============================================================
git status

# ============================================================
# 2. git status after change — shows modified file
# ============================================================
echo "Second line" >> file.txt
git status

# ============================================================
# 3. git log — full commit info (author, date, message)
# ============================================================
git log

# ============================================================
# 4. git log --oneline — compact view
# ============================================================
git log --oneline

# ============================================================
# 5. git log with graph — shows branch structure
# ============================================================
git log --oneline --graph

# ============================================================
# 6. Adding a second commit
# ============================================================
git add file.txt
git commit -m "Add second line" > /dev/null
git log --oneline --graph --all

cd /tmp
rm -rf "$PLAYGROUND"
