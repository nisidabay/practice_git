#!/bin/bash
# project/undo-history.sh — safely undo commit ranges
# Usage: bash undo-history.sh <ref> [--range <ref>]
set -euo pipefail

do_revert() {
    local ref="$1"
    echo "=== Undoing: $ref ==="
    git show --oneline --no-patch "$ref"
    git revert --no-edit "$ref"
}

if [ "$#" -eq 0 ]; then
    echo "Usage:"
    echo "  bash undo-history.sh <commit>             # revert one commit"
    echo "  bash undo-history.sh <commit>..<commit>   # revert a range"
    echo "  bash undo-history.sh --abort              # abort a revert in progress"
    echo "  bash undo-history.sh --list               # show last 10 commits"
    exit 1
fi

case "$1" in
    --abort)
        git revert --abort
        echo "Revert aborted."
        ;;
    --list)
        git log --oneline -10
        ;;
    *)
        do_revert "$1"
        ;;
esac
