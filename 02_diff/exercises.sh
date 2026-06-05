#!/bin/bash
# exercises.sh — Diff group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: staged vs unstaged ===
git init
echo "A" > file.txt
git add file.txt
git commit -m "C1" > /dev/null
echo "B" >> file.txt     # unstaged change
echo "C" > file2.txt
git add file2.txt          # staged change (new file)

echo "Unstaged diff (file.txt modified):"
git diff
echo "---"
echo "Staged diff (file2.txt added):"
git diff --staged
echo "---"

# === Exercise 2: diff between two branches ===
echo "Initial" > shared.txt
git add shared.txt
git commit -m "shared" > /dev/null
git checkout -b side 2>/dev/null
echo "side-work" >> shared.txt
git add shared.txt
git commit -m "side change" > /dev/null
git checkout main 2>/dev/null

echo "Diff main vs side:"
git diff main..side
echo "(you should see 'side-work' added)"
echo "---"

# === Exercise 3: word-diff vs default diff ===
echo "She sells sea shells" > line.txt
git add line.txt
git commit -m "word test" > /dev/null
echo "She buys sea shells" > line.txt

echo "Default diff (whole line):"
git diff
echo ""
echo "Word diff (pinpoints 'buys'):"
git diff --word-diff
echo "---"

# === Exercise 4: range diff with HEAD~N ===
echo "v1" >> history.txt
git add history.txt
git commit -m "one" > /dev/null
echo "v2" >> history.txt
git add history.txt
git commit -m "two" > /dev/null
echo "v3" >> history.txt
git add history.txt
git commit -m "three" > /dev/null

echo "Last 2 commits worth of changes:"
git diff HEAD~2..HEAD --stat
echo "---"

# === BONUS ===
echo "Show diff of just filenames (--name-only):"
git diff HEAD~3..HEAD --name-only

rm -rf "$PG"
