#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_git_grep.sh: playground at $PLAYGROUND"

git init

echo "TODO: implement login" > auth.py
echo "def authenticate(user, pass):" >> auth.py
echo "    return True  # FIXME: real auth" >> auth.py
git add auth.py
git commit -m "Add auth module" > /dev/null

echo "TODO: password hashing" >> auth.py
git add auth.py
git commit -m "Add hashing TODO" > /dev/null

echo "print('done')" > main.py
echo "# TODO: wire up auth" >> main.py
git add main.py
git commit -m "Add main entry point" > /dev/null

# ============================================================
# 1. git grep — search working tree
# ============================================================
echo "=== Files containing 'TODO' in working tree: ==="
git grep "TODO"
echo ""

# ============================================================
# 2. git grep with count
# ============================================================
echo "=== Count of TODO per file: ==="
git grep -c "TODO"
echo ""

# ============================================================
# 3. git grep in a specific commit (not just working tree!)
# ============================================================
# Vanilla git:
FIRST=$(git rev-list --reverse HEAD | head -1)
# Pipe con awk:
FIRST=$(git log --oneline --reverse --max-count=1 | awk '{print $1}')
echo "=== 'TODO' in the first commit ($FIRST): ==="
git grep "TODO" "$FIRST" || echo "(no matches in that commit — expected for the first one)"
echo ""

echo "=== git grep searches the TRACKED files in the working tree ==="
echo "=== git grep PATTERN <commit> searches in any commit ==="
echo "=== Unlike rg/grep, it ignores untracked and .gitignored files ==="

cd /tmp
rm -rf "$PLAYGROUND"
