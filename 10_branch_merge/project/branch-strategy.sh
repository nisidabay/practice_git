#!/bin/bash
# project/branch-strategy.sh — simulate feature/hotfix/release workflow locally
# Usage: bash branch-strategy.sh <command>
set -euo pipefail

cmd="${1:-help}"

case "$cmd" in
    feature)
        NAME="${2:-new-feature}"
        git switch -c "feature/$NAME"
        echo "Now on feature/$NAME — create commits normally."
        echo "When done: git switch main && git merge --no-ff feature/$NAME"
        ;;
    hotfix)
        NAME="${2:-critical-fix}"
        git switch -c "hotfix/$NAME" main
        echo "Now on hotfix/$NAME — fix the bug."
        echo "When done: git switch main && git merge --no-ff hotfix/$NAME"
        echo "Then: git branch -d hotfix/$NAME"
        ;;
    merge)
        BRANCH="${2:-}"
        if [ -z "$BRANCH" ]; then
            echo "Usage: bash branch-strategy.sh merge <branch>"
            echo "Current branches:"
            git branch
            exit 1
        fi
        CURRENT=$(git branch --show-current)
        git merge --no-ff "$BRANCH" -m "Merge $BRANCH into $CURRENT"
        echo "Merged. Clean up with: git branch -d $BRANCH"
        ;;
    cleanup)
        echo "=== Merged branches (safe to delete with -d): ==="
        git branch --merged | grep -v 'main\|*' || echo "(none)"
        echo ""
        echo "=== All branches: ==="
        git branch
        ;;
    log)
        git log --oneline --graph --all -20
        ;;
    *)
        echo "Usage:"
        echo "  bash branch-strategy.sh feature [name]     # start a feature branch"
        echo "  bash branch-strategy.sh hotfix [name]       # start a hotfix from main"
        echo "  bash branch-strategy.sh merge <branch>      # merge into current branch"
        echo "  bash branch-strategy.sh cleanup             # list merged branches"
        echo "  bash branch-strategy.sh log                 # show full history graph"
        ;;
esac
