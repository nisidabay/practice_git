#!/bin/bash
# exercises.sh — Revert group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# Exercise 1: revert a single commit
git init
echo "good" > good1.txt
git add good1.txt
git commit -m "good" > /dev/null
echo "bad" > bad.txt
git add bad.txt
git commit -m "bad" > /dev/null
echo "good again" > good2.txt
git add good2.txt
git commit -m "good again" > /dev/null

echo "Before revert:"
ls *.txt
echo "---"

BAD=$(git log --oneline | grep 'bad' | awk '{print $1}')
git revert --no-edit "$BAD"
echo "After revert (bad.txt gone):"
ls *.txt
echo "---"

# Exercise 2: revert preserves history
echo "History (old commits remain):"
git log --oneline
echo "---"

# Exercise 3: revert a range
echo "1" > nums1.txt; git add nums1.txt; git commit -m "C1" > /dev/null
echo "2 bad" > nums2.txt; git add nums2.txt; git commit -m "C2 bad" > /dev/null
echo "3 bad" > nums3.txt; git add nums3.txt; git commit -m "C3 bad" > /dev/null
echo "4" > nums4.txt; git add nums4.txt; git commit -m "C4" > /dev/null

C2=$(git log --oneline --reverse | grep 'C2' | awk '{print $1}')
C3=$(git log --oneline --reverse | grep 'C3' | awk '{print $1}')
git revert --no-edit "$C2..$C3"
echo "After reverting C2 and C3 (bad files gone):"
ls *.txt
echo "---"

# Exercise 4: revert the revert
git revert --no-edit HEAD 2>/dev/null || git revert --abort 2>/dev/null
echo "---"

# BONUS
echo "Count commits: $(git log --oneline | wc -l)"
echo "(many commits = revert never deletes history)"

rm -rf "$PG"
