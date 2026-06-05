#!/bin/bash
# project/cleanup-history.sh — squashes WIP/fixup commits into narrative history
# Usage: bash cleanup-history.sh [N]
#   N = number of commits from HEAD to squash (default: look for "WIP" and "fixup" messages)
set -euo pipefail

N="${1:-}"

if [ -z "$N" ]; then
    # Auto-detect: find the range from HEAD back to before the first WIP/fixup
    echo "=== Scanning for WIP/fixup commits... ==="
    git log --oneline -20 | grep -iE 'wip|fixup|squash!|typo|tmp|temp'
    echo ""
    echo "Run with a number to squash that many commits:"
    echo "  bash cleanup-history.sh 5"
    echo "This opens GIT_SEQUENCE_EDITOR. Change pick→squash, save, done."
    exit 0
fi

echo "=== Interactive rebase for last $N commits ==="
echo "Change 'pick' to 'squash' (or 's'/'f') for commits you want to absorb."
echo ""
GIT_SEQUENCE_EDITOR="${EDITOR:-vim}" \
git rebase -i "HEAD~$N"
