#!/bin/bash
GIT_DIR=$(git rev-parse --git-dir)
echo "Installing hooks…"
echo "Pre-Push"
ln -s pre-push.bash $GIT_DIR/hooks/pre-push

echo “Done!”