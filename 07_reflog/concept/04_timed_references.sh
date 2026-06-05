#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 04_timed_references.sh: playground at $PLAYGROUND"

git init
echo "C1" > file.txt; git add file.txt; git commit -m "C1" > /dev/null

echo "=== Timed references in reflog: ==="
echo ""
echo "HEAD@{0}          — now"
echo "HEAD@{1}          — one move ago"
echo "HEAD@{5}          — five moves ago"
echo "HEAD@{5.minutes.ago}  — where HEAD was 5 minutes ago"
echo "HEAD@{2.hours.ago}    — where HEAD was 2 hours ago"
echo "HEAD@{yesterday}      — where HEAD was yesterday"
echo "HEAD@{1.week.ago}     — where HEAD was a week ago"
echo ""

# ============================================================
# Try a timed reference (won't work in fresh repo, but shows syntax)
# ============================================================
echo "=== Current reflog: ==="
git reflog | head -5

echo ""
echo "=== What was HEAD 5 minutes ago? ==="
git rev-parse HEAD@{5.minutes.ago} 2>/dev/null || echo "(5 min ago doesn't exist in this fresh repo — expected)"
echo ""

echo "=== main@{yesterday} — where was main yesterday? ==="
git rev-parse main@{yesterday} 2>/dev/null || echo "(yesterday doesn't exist — expected)"
echo ""

echo "=== Timed references work when the reflog has entries that old ==="
echo "=== 'What was I working on 3 hours ago?' → git log HEAD@{3.hours.ago} ==="

cd /tmp
rm -rf "$PLAYGROUND"
