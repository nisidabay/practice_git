#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 02_log_pickaxe.sh: playground at $PLAYGROUND"

git init

# ============================================================
# 1. Build history where a string appears and disappears
# ============================================================
echo "function calculate_tax(amount) {" > tax.py
echo "    return amount * 0.08" >> tax.py
echo "}" >> tax.py
git add tax.py
git commit -m "Add tax calculation" > /dev/null

sed -i 's/0\.08/0.10/' tax.py
git add tax.py
git commit -m "Update tax rate to 10%" > /dev/null

sed -i 's/function calculate_tax.*/function process_payment(amount) {/' tax.py
sed -i 's/    return amount \* 0\.10/    # tax calculation removed/' tax.py
echo "    return amount" >> tax.py
echo "}" >> tax.py
git add tax.py
git commit -m "Remove tax calculation" > /dev/null

echo "=== All commits: ==="
git log --oneline

# ============================================================
# 2. -S (pickaxe): find commits where 'calculate_tax' appeared or disappeared
# ============================================================
echo ""
echo "=== Commits where 'calculate_tax' was added or removed: ==="
git log --oneline -S "calculate_tax"

echo ""
echo "=== -S = 'show me commits that changed the number of occurrences of this string' ==="
echo "=== Use it to find when a function was added or deleted ==="

cd /tmp
rm -rf "$PLAYGROUND"
