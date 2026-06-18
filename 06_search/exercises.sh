#!/bin/bash
# exercises.sh — Search group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: grep by message ===
git init
echo "code" > file.txt; git add file.txt
git commit -m "feat: add file" > /dev/null
echo "more" >> file.txt; git add file.txt
git commit -m "fix: typo" > /dev/null
echo "even more" >> file.txt; git add file.txt
git commit -m "chore: cleanup" > /dev/null

echo "Commits matching 'fix':"
git log --oneline --grep="fix"
echo "---"

# === Exercise 2: pickaxe (-S) ===
echo "void setup() {" > main.c; echo "}" >> main.c
git add main.c; git commit -m "Add setup" > /dev/null
sed -i '/^{$/a\    init();' main.c
git add main.c; git commit -m "Add init call" > /dev/null

echo "Commit where 'init' first appeared:"
git log --oneline -S "init"
echo "---"

# === Exercise 3: diff search (-G) ===
echo "Commits whose diff matches 'more' OR 'even' (regex):"
git log --oneline -G "more|even"
echo "---"

# === Exercise 4: git grep ===
echo "// BUG: off-by-one" > bug.c
echo "int main() {" >> bug.c
echo "    return 0;" >> bug.c
echo "}" >> bug.c
git add bug.c; git commit -m "Add buggy code" > /dev/null

echo "Files with BUG markers:"
git grep -l "BUG"
echo "---"

# === Exercise 5: git blame ===
echo "line 1" > blame.txt; git add blame.txt; git commit -m "C1" > /dev/null
echo "line 2" >> blame.txt; git add blame.txt; git commit -m "C2" > /dev/null

echo "Blame (who wrote each line):"
git blame blame.txt
echo "---"

# === BONUS ===
echo "Find commits that ADDED the word 'line' (not files that already had it):"
git log --oneline -S "line"

rm -rf "$PG"
