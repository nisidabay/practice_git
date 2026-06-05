#!/bin/bash
set -euo pipefail

PLAYGROUND=$(mktemp -d)
cd "$PLAYGROUND"
echo "--- 01_init_add_commit.sh: playground at $PLAYGROUND"

# ============================================================
# 1. git init — create a repository
# ============================================================
git init

# ============================================================
# 2. git status — check what's going on
# ============================================================
git status

# ============================================================
# 3. First commit — create a file, stage it, commit it
# ============================================================
echo "Hello Git" > README.md
git add README.md
git commit -m "Initial commit: add README"

# ============================================================
# 4. Second commit — modify + commit
# ============================================================
echo "Git tracks changes per line" >> README.md
git add README.md
git commit -m "Add second line to README"

# ============================================================
# 5. What happened? — git log
# ============================================================
git log --oneline

cd /tmp
rm -rf "$PLAYGROUND"
