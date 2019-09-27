#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# Run our compile script
mkdir -p ./gh-pages
gitbook build $(pwd) ./gh-pages
