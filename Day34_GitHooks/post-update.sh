#!/bin/bash
# .git/hooks/post-update
# /opt/demo.git/hooks/post-update

# Check if master branch was updated
for ref in "$@"; do
    if [ "$ref" = "refs/heads/master" ]; then
        DATE=$(date +%Y-%m-%d)
        TAG_NAME="release-$DATE"
        
        # Create tag at latest commit on master
        git tag "$TAG_NAME" master
        
        echo "Created tag: $TAG_NAME"
        echo "Hook triggered at $(date)" > /tmp/post-update-debug.log
        echo "Args: $@" >> /tmp/post-update-debug.log
        break
    fi
done