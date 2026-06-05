#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_fixup_autosquash.sh: playground at $PLAYGROUND"

git init

echo "base" > README.md
git add README.md
git commit -m "Initial base" > /dev/null

# ============================================================
# 1. Make a commit, then make a quick fix
# ============================================================
echo "line 1" > main.c
echo "line 2" >> main.c
git add main.c
git commit -m "Implement parser" > /dev/null

# Later: oh wait, forgot a semicolon
echo "line 3; // oops missing semicolon in parser" >> main.c
git add main.c

# ============================================================
# 2. git commit --fixup points to the commit we want to fix
#    This creates a special commit with subject "fixup! Implement parser"
# ============================================================
git commit -m "fixup! Implement parser" > /dev/null

echo "=== Before autosquash — two commits: ==="
git log --oneline
echo ""

# ============================================================
# 3. git rebase --autosquash automatically reorders and squashes
#    The fixup commit gets moved right after the target and squashed
# ============================================================
GIT_SEQUENCE_EDITOR=true GIT_EDITOR=true \
git rebase -i --autosquash HEAD~2

echo "=== After autosquash — one commit, fix absorbed: ==="
git log --oneline

echo ""
echo "=== main.c has all 3 lines in one commit: ==="
cat main.c

echo ""
echo "=== fixup workflow: ==="
echo "=== 1. Commit = 'Implement parser'"
echo "=== 2. Make a fix"
echo "=== 3. git commit --fixup=<hash of commit 1>"
echo "=== 4. git rebase -i --autosquash HEAD~N"
echo "==="
echo "=== --fixup is the signal. --autosquash does the work. ==="
echo "=== Also: git commit --squash for when you want to edit the message ==="

cd /tmp
rm -rf "$PLAYGROUND"
