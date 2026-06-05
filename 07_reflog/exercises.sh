#!/bin/bash
# exercises.sh — Reflog group. Solved problems.
set -euo pipefail

PG=$(mktemp -d)
cd "$PG"

# === Exercise 1: read the reflog ===
git init
echo "c1" > f.txt; git add f.txt; git commit -m "C1" > /dev/null
echo "c2" >> f.txt; git add f.txt; git commit -m "C2" > /dev/null

echo "Reflog entries (each HEAD movement):"
git reflog | head -5
echo "---"

# === Exercise 2: recover from reset --hard ===
echo "base" > important.txt; git add important.txt; git commit -m "Base" > /dev/null
echo "important change" >> important.txt; git add important.txt; git commit -m "Lost work" > /dev/null
echo "Content before reset:"; cat important.txt
git reset --hard HEAD~1 2>/dev/null
echo "---"
echo "After reset --hard (content gone):"; cat important.txt
echo "(empty or just 'base' — the change is lost)"
# Recover from reflog — reset --hard to HEAD@{1} restores everything
git reset --hard HEAD@{1} 2>/dev/null
echo "---"
echo "After recovering with git reset --hard HEAD@{1}:"
cat important.txt
echo "---"

# === Exercise 3: HEAD@{N} syntax ===
echo "v1" > v.txt; git add v.txt; git commit -m "V1" > /dev/null
echo "v2" >> v.txt; git add v.txt; git commit -m "V2" > /dev/null

echo "HEAD@{0} = $(git rev-parse --short HEAD@{0})"
echo "HEAD@{1} = $(git rev-parse --short HEAD@{1})"
echo "HEAD@{2} = $(git rev-parse --short HEAD@{2})"
echo "---"

# === Exercise 4: find deleted work ===
git checkout -b doomed 2>/dev/null
echo "treasure" > treasure.txt; git add treasure.txt; git commit -m "Treasure" > /dev/null
DOOMED_HASH=$(git rev-parse HEAD)
git checkout main 2>/dev/null
git branch -D doomed 2>/dev/null

echo "Branch deleted. Recovering from hash:"
git checkout -b saved "$DOOMED_HASH" 2>/dev/null
echo "Treasure: $(cat treasure.txt)"
echo "---"

# === BONUS ===
echo "The reflog is Git's Undo button. It records EVERY movement of HEAD."
echo "  git reflog            — list all movements"
echo "  git reset HEAD@{N}    — jump back N steps"

rm -rf "$PG"
