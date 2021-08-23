#!/bin/sh

git remote update
git fetch --all

# retrieve git sha
SHA=$(git rev-parse --short HEAD)

# Get current branch name, the one you want to cherry pick to
LATEST_BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# PR Branch name
PR_BRANCH="Auto-$LATEST_BRANCH_NAME-$SHA"

# Retrieve the latest commit hash
LATEST_COMMIT_HASH=$(git log --pretty=format:'%h' -n 1)

# Create commit message
MSG=$(git log -1 --format="%s" "$LATEST_COMMIT_HASH")


if [ -z "$1" ]; then
	echo "Usage: cherrypick.sh <hash> [<branch1> <branch2> <branch3> ...]"
	echo 
	echo "e.g. cherrypick.sh fb5cfe1cf2165abee 1.0.0 1.1.0 1.2.0"
	exit
else 
	for arg in "${@:1}"
	do
		git checkout "$arg"
		create_pr "$SHA"		
	done
fi

cherry_pr(){
    git checkout -b "$PR_BRANCH" origin/"$LATEST_BRANCH_NAME"
    git cherry-pick -x "$SHA"
    git push -u origin "${PR_BRANCH}"
    hub pull-request -m "$MSG" -b "$LATEST_BRANCH_NAME" -h "$PR_BRANCH"
}



# TODO: Add Argument parser for target branches, Loop checkout/cherry-pick/push/pull-request
# Optional: Create GH Actions workflow to automate this process On Push
# Other optional: Publish it as a GitHub Action