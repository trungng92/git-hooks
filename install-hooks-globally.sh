#!/bin/bash
# This script installs a git hook globally, which means it will apply to all repos that you have on your computer
# Usage:
# ./install-hook-globally.sh {{path to hook}} {{global path}}
#
# Example (install the prepare-commit-msg hook to ~/.git-hooks):
#
# ./install-hook hooks/prepare-commit-msg ~/.git-hooks

HOOK_PATH="$1"
INSTALL_PATH="$2"

[  -z "$HOOK_PATH" ] && echo "Error: HOOK_PATH variable is empty" && exit 1
[ -z "$INSTALL_PATH" ] && echo "Error: INSTALL_PATH variable is empty" && exit 2

HOOK_BASENAME=$(basename $HOOK_PATH)
HOOK_INSTALL_PATH="$INSTALL_PATH/$HOOK_BASENAME"

! [ -f "$HOOK_INSTALL_PATH" ] || { echo "Error: Already detected a hook with the path $HOOK_INSTALL_PATH" && exit 3; }

HOOK_PATH_SETTING=$(git config --global --get core.hooksPath)

{ [ -z "$HOOK_PATH_SETTING" ] || [ "$HOOK_PATH_SETTING" = "$INSTALL_PATH" ]; } || { echo "Error: git config setting 'core.hooksPath' already set to $HOOK_PATH_SETTING" && exit 6; }

mkdir -p "$INSTALL_PATH" || { echo "Error: Could not create directory $INSTALL_PATH" && exit 4; }

echo "Copying $HOOK_PATH to $HOOK_INSTALL_PATH"
cp "$HOOK_PATH" "$HOOK_INSTALL_PATH" || { echo "Error: Failed to copy hook" && exit 5; }

git config --global core.hooksPath "$INSTALL_PATH" || { echo "Error: Failed to setup global hook path. Check settings with 'git config --global --list' " && exit 7; }

echo "Hook successfully installed. Make sure to set any environment variables that may need to be set"