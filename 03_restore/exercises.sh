#!/bin/bash
# exercises.sh — Restore group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: discard changes in a single file ===
git init
echo "keep this" > keep.txt
git add keep.txt
git commit -m "C1" > /dev/null
echo "junk" >> keep.txt
echo "keep this too" >> keep.txt

echo "Before restore — file has 3 lines:"
cat keep.txt
echo "---"
git restore keep.txt
echo "After restore — back to 1 line:"
cat keep.txt
echo "---"

# === Exercise 2: unstage a file ===
echo "staged junk" >> keep.txt
git add keep.txt
echo "Staged diff before unstage:"
git diff --staged
echo "---"
git restore --staged keep.txt
echo "Staged diff after unstage (should be empty):"
git diff --staged
echo "---"
echo "But the change is still in working tree:"
git diff
echo "---"

# === Exercise 3: restore from old commit ===
echo "A" > time.txt
git add time.txt
git commit -m "A" > /dev/null
echo "B" > time.txt
git add time.txt
git commit -m "B" > /dev/null
echo "C" > time.txt
git add time.txt
git commit -m "C" > /dev/null

FIRST=$(git log --oneline --reverse --max-count=1 | awk '{print $1}')
echo "Current time.txt: $(cat time.txt)"
git restore --source="$FIRST" time.txt
echo "After restoring from first commit: $(cat time.txt)"
echo "---"

# === Exercise 4: restore a deleted file ===
echo "precious" > precious.txt
git add precious.txt
git commit -m "save precious" > /dev/null
rm precious.txt
echo "precious.txt was deleted — git status shows it:"
git status
echo "---"
echo "Restore it from HEAD:"
git restore precious.txt
echo "precious.txt content: $(cat precious.txt)"
echo "---"

# === BONUS ===
echo "What happens if you restore --staged a NEW file (never committed)?"
echo "new file" > new.txt
git add new.txt
git restore --staged new.txt
echo "new.txt is now untracked:"
git status

rm -rf "$PG"
