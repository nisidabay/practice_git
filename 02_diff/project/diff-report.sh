#!/bin/bash
# project/diff-report.sh — human-readable diff summary between any two commits
# Usage: bash diff-report.sh <from-ref> <to-ref>
set -euo pipefail

FROM="${1:-HEAD~1}"
TO="${2:-HEAD}"

echo "=== Diff report: $FROM → $TO ==="
echo ""

# Files changed
echo "Files changed:"
git diff --name-status "$FROM..$TO"
echo ""

# Stats
echo "Stats:"
git diff --stat "$FROM..$TO"
echo ""

# Commits
echo "Commits in range:"
git log --oneline "$FROM..$TO"
echo ""

# Word-level differences
echo "Detailed changes (word-level):"
git diff --word-diff "$FROM..$TO"
