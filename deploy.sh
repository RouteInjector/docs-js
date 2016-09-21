#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"


# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy."
    exit 0
fi

# Run our compile script
mkdir /tmp/gh-pages
gitbook-cli build $(pwd) /tmp/gh-pages

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
# ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
# ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
# ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
# ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
# openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in travis_deploy.enc -out travis_deploy -d
chmod 600 travis_deploy
eval `ssh-agent -s`
ssh-add travis_deploy

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
cd /tmp/gh-pages

git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

git add .
git commit -m "Deploy to GitHub Pages: ${SHA}"

# Now that we're all set up, we can push.
git push --force --quiet $SSH_REPO $TARGET_BRANCH
