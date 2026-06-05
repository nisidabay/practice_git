#!/bin/bash
# project/init-template.sh — Initialize a git repo with README and .gitignore
# Usage: bash project/init-template.sh my-new-project
set -euo pipefail

NAME="${1:-}"
if [ -z "$NAME" ]; then
    echo "Usage: bash init-template.sh <project-name>"
    exit 1
fi

mkdir -p "$NAME"
cd "$NAME"
git init

cat > README.md << EOF
# $NAME

Project description here.
EOF

cat > .gitignore << 'EOF'
*.swp
*.swo
.DS_Store
Thumbs.db
EOF

git add README.md .gitignore
git commit -m "Initial commit: README and .gitignore"

echo "Repo $NAME ready at $(pwd)"
git log --oneline
git status
