#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 05_reflog_expire.sh: playground at $PLAYGROUND"

# ============================================================
# DANGER ZONE. This file explains expiration — does NOT run it.
# ============================================================

echo "=== Reflog expiration — DANGER ZONE ==="
echo ""
echo "By default, reflog entries expire after 90 days (unreachable)"
echo "or are kept forever (reachable)."
echo ""
echo "Commands that DESTROY reflog data (read, don't run blindly):"
echo "  git reflog expire --expire=now --all"
echo "  git reflog delete HEAD@{5}"
echo ""
echo "After reflog entries are gone, recovery is IMPOSSIBLE."
echo ""
echo "=== Safe operations: ==="
echo "  git reflog                    # read the reflog"
echo "  git reflog show main          # show reflog for a specific ref"
echo "  git gc                        # garbage collect (keeps 90-day default)"
echo ""
echo "=== When you might expire reflog (rare): ==="
echo "  - After git filter-branch removing a huge binary file"
echo "  - Disk space is critical and you've verified no recovery needed"
echo ""
echo "=== 99% of the time: just let it expire naturally ==="

cd /tmp
rm -rf "$PLAYGROUND"
