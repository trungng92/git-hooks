#!/bin/bash
# This script installs a git hook directly to a git repo
# Usage:
# ./install-hook {{path to hook}} {{path to git repo}}
#
# Example (install the prepare-commit-msg hook to the git-hooks repo):
#
# ./install-hook hooks/prepare-commit-msg ~/src/projects/git-hooks

HOOK_PATH="$1"
REPO_PATH="$2"

[  -z "$HOOK_PATH" ] && echo "Error: HOOK_PATH variable is empty" && exit 1
[ -z "$REPO_PATH" ] && echo "Error: REPO_PATH variable is empty" && exit 2

HOOK_BASENAME=$(basename $HOOK_PATH)
GIT_BASE="$REPO_PATH/.git"
HOOK_INSTALL_PATH="$REPO_PATH/.git/hooks/$HOOK_BASENAME"

[ -d "$GIT_BASE" ] || { echo "Error: did not detect a .git directory in $REPO_PATH" && exit 3; }
! [ -f "$HOOK_INSTALL_PATH" ] || { echo "Error: Already detected a hook with the path $HOOK_INSTALL_PATH" && exit 4; }

echo "Copying $HOOK_PATH to $HOOK_INSTALL_PATH"
cp "$HOOK_PATH" "$HOOK_INSTALL_PATH" || { echo "Error: Failed to copy hook" && exit 5; }
echo "Hook successfully installed. Make sure to set any environment variables that may need to be set"