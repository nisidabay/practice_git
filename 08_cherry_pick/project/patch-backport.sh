#!/bin/bash
# project/patch-backport.sh — backport a fix from any branch to main
# Usage: bash patch-backport.sh <source-branch> <commit-hash>
set -euo pipefail

SRC="${1:-}"
HASH="${2:-}"

if [ -z "$SRC" ] || [ -z "$HASH" ]; then
    echo "Usage: bash patch-backport.sh <source-branch> <commit-hash>"
    echo ""
    echo "Backports a single commit from any branch to the current branch."
    echo "Uses -x to record the source."
    echo ""
    echo "Example: bash patch-backport.sh hotfix abc123"
    exit 1
fi

echo "=== Backporting $HASH from $SRC ==="
echo "Commit message:"
git log -1 --oneline "$HASH"
echo ""

echo "Applying..."
if git cherry-pick -x "$HASH" 2>/dev/null; then
    echo "✓ Backported successfully."
    echo "Run 'git log -1' to see the new commit with source annotation."
else
    echo "✗ Conflict detected. Fix it, then:"
    echo "  git add <files>"
    echo "  git cherry-pick --continue"
    echo "Or abort: git cherry-pick --abort"
    exit 1
fi
