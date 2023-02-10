#!/bin/bash
GIT_DIR=$(git rev-parse --git-dir)
echo "Installing hooks…"
echo "Pre-Push"
ln -s pre-commit $GIT_DIR/hooks/pre-commit

echo “Done!”