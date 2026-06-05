#!/bin/bash
# project/git-find.sh — unified search across log, grep, and blame
# Usage: bash git-find.sh <pattern> [--all] [--log] [--grep] [--blame <file>]
set -euo pipefail

PATTERN="${1:-}"

if [ -z "$PATTERN" ]; then
    echo "Usage:"
    echo "  bash git-find.sh <pattern>                # search log + grep"
    echo "  bash git-find.sh <pattern> --log          # only git log -S"
    echo "  bash git-find.sh <pattern> --grep         # only git grep"
    echo "  bash git-find.sh <pattern> --blame <file> # only git blame"
    exit 1
fi

MODE="${2:-}"

case "$MODE" in
    --log)
        echo "=== Commits that changed '$PATTERN': ==="
        git log --oneline -S "$PATTERN"
        ;;
    --grep)
        echo "=== Files containing '$PATTERN': ==="
        git grep -n "$PATTERN" || echo "(none)"
        ;;
    --blame)
        FILE="${3:?Need file path}"
        echo "=== Blame for lines matching '$PATTERN' in $FILE: ==="
        git blame "$FILE" | grep -i "$PATTERN" || echo "(none)"
        ;;
    *)
        echo "=== Commits that changed '$PATTERN': ==="
        git log --oneline -S "$PATTERN"
        echo ""
        echo "=== Files containing '$PATTERN': ==="
        git grep -n "$PATTERN" || echo "(none)"
        ;;
esac
