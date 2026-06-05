#!/bin/bash
# project/reflog-rescue.sh — guided recovery tool for lost work
set -euo pipefail

case "${1:-}" in
    --list)
        echo "=== Recent HEAD movements (last 20): ==="
        git reflog -20
        ;;
    --recover)
        N="${2:-1}"
        echo "=== Jumping to HEAD@{$N} ==="
        git reflog | head -$((N+1))
        echo ""
        echo "Run:  git reset HEAD@{$N}"
        echo "(This modifies your working tree — be sure you want this)"
        ;;
    --branch)
        NAME="${2:-recovered}"
        echo "=== Recovering last deleted branch as '$NAME' ==="
        # Find the last checkout: moving from <branch> to main
        LOST=$(git reflog | grep -m1 "checkout: moving" | awk '{print $1}')
        if [ -n "$LOST" ]; then
            git checkout -b "$NAME" "$LOST"
            echo "Recovered as branch '$NAME'"
        else
            echo "No recent branch switch found in reflog"
        fi
        ;;
    *)
        echo "Usage:"
        echo "  bash reflog-rescue.sh --list              # show reflog"
        echo "  bash reflog-rescue.sh --recover [N]       # reset to HEAD@{N}"
        echo "  bash reflog-rescue.sh --branch [name]     # recover deleted branch"
        ;;
esac
