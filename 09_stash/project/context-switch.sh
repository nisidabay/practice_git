#!/bin/bash
# project/context-switch.sh — save and restore full working state
# Usage: bash context-switch.sh save [name]  /  restore [name]  /  list
set -euo pipefail

case "${1:-}" in
    save)
        NAME="${2:-auto}"
        MSG="context:$NAME"
        if git stash push -u -m "$MSG" 2>/dev/null; then
            echo "✓ Context '$NAME' saved. Working tree is clean."
        else
            echo "(nothing to stash — working tree already clean)"
        fi
        ;;
    restore)
        NAME="${2:-auto}"
        MSG="context:$NAME"
        # Find stash with this message
        IDX=$(git stash list | grep "context:$NAME" | awk 'NR==1{print $1}' | tr -d ':')
        if [ -n "$IDX" ]; then
            git stash pop "$IDX"
            echo "✓ Context '$NAME' restored."
        else
            echo "✗ No context named '$NAME' found."
            echo "Available:"
            git stash list | grep "context:" || echo "(none)"
        fi
        ;;
    list)
        echo "=== Saved contexts ==="
        git stash list | grep "context:" || echo "(none)"
        ;;
    *)
        echo "Usage:"
        echo "  bash context-switch.sh save [name]    # stash everything"
        echo "  bash context-switch.sh restore [name]  # restore named stash"
        echo "  bash context-switch.sh list            # list saved contexts"
        ;;
esac
