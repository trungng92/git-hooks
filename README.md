# Summary

A list of commit hooks I've reused over and over that I've decided to source control.

# How to install

To install them, you can use the handy-dandy install scripts that are in the repo. You can install hooks globally (with `install-hooks-globally.sh`), or per repo (with `install-hooks.sh`)

**Examples**

```bash
./install-hooks.sh hooks/prepare-commit-msg ~/my-git-repo
```

```bash
./install-hooks-globally.sh hooks/prepare-commit-msg ~/.my-global-git-hook-dir
```

# Hooks

## `prepare-commit-msg`

A hook that takes in a branch name and uses it to prefix commit messages:

```
# Using these two environment variables will make all of your commits on this branch start out with JIRA:ABC-1234

## optional prefix at the beginning of the commit message
export COMMIT_MSG_PREFIX='JIRA:'

## the actual expression from the branch name that we want to put in the commit message
export COMMIT_MSG_REGEX_EXPRESSION='ABC-[0-9]*'
```