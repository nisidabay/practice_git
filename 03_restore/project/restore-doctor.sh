#!/bin/bash
# project/restore-doctor.sh — interactively restore files from history
# Usage: bash restore-doctor.sh <file> <commit>
# Without args: shows options and usage
set -euo pipefail

FILE="${1:-}"
COMMIT="${2:-}"

if [ -z "$FILE" ]; then
    echo "Usage:"
    echo "  bash restore-doctor.sh <file>              # restore to HEAD"
    echo "  bash restore-doctor.sh <file> <commit>     # restore to specific commit"
    echo "  bash restore-doctor.sh <file> --pick        # choose from versions in log"
    exit 1
fi

if [ "$COMMIT" = "--pick" ]; then
    echo "=== Versions of $FILE in history ==="
    git log --oneline --follow -- "$FILE"
    read -rp "Enter commit hash to restore from: " chosen
    COMMIT="$chosen"
fi

if [ -z "$COMMIT" ]; then
    echo "Restoring $FILE to HEAD state..."
    git restore --source=HEAD "$FILE"
else
    echo "Restoring $FILE to commit $COMMIT..."
    git restore --source="$COMMIT" "$FILE"
fi

echo "Done. Run 'git diff' to see what changed."
echo "Run 'git restore $FILE' to undo this restore."
