#!/bin/bash

# Ensure we're on the develop branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "develop" ]; then
  echo "You must be on the 'develop' branch to run this script."
  exit 1
fi

# Extract the current version from package.json
VERSION=$(jq -r '.version' package.json)

# Create a new feature branch based on the version
FEATURE_BRANCH="release/v$VERSION"
git checkout -b "$FEATURE_BRANCH"

# Run standard-version for version bumping
npx standard-version --prerelease alpha

# Commit changes
git add .
git commit -m "chore(release): bump version to $VERSION"

# Notify the user about the feature branch
echo "Version bumped and committed on branch $FEATURE_BRANCH."

# Instructions for further actions (manual steps)
echo "Next steps:"
echo "- Review the changes in the feature branch."
echo "- Push the branch to the remote repository if necessary."