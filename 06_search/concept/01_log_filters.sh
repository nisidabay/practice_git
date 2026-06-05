#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_log_filters.sh: playground at $PLAYGROUND"

git init

# ============================================================
# 1. Build a history with different authors, dates, messages
# ============================================================
echo "file 1" > file1.txt
git add file1.txt
GIT_COMMITTER_DATE="2024-01-15 10:00:00" git commit -m "Add file1" --date="2024-01-15 10:00:00" > /dev/null

echo "file 2" >> file1.txt
git add file1.txt
GIT_COMMITTER_DATE="2024-02-20 14:00:00" git commit -m "fix: update file1" --date="2024-02-20 14:00:00" > /dev/null

echo "file 3" > file2.txt
git add file2.txt
GIT_COMMITTER_DATE="2024-03-10 09:00:00" git commit -m "Add file2 with new feature" --date="2024-03-10 09:00:00" > /dev/null

echo "== All commits: =="
git log --oneline
echo ""

# ============================================================
# 2. Filter by message: --grep
# ============================================================
echo "== Commits containing 'fix': =="
git log --oneline --grep="fix"
echo ""

# ============================================================
# 3. Filter by date: --since / --until
# ============================================================
echo "== Commits since Feb 2024: =="
git log --oneline --since="2024-02-01"
echo ""

# ============================================================
# 4. Combine filters
# ============================================================
echo "== Commits since Feb containing 'file': =="
git log --oneline --since="2024-02-01" --grep="file"
echo ""

echo "=== --grep, --since, --until, --author all work together ==="
echo "=== git log --all-match requires ALL --grep patterns to match ==="

cd /tmp
rm -rf "$PLAYGROUND"
