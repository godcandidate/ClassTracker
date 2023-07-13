#!/bin/bash

DIRECTORY="codebase/frontend/andriod"

# Iterate over each file in the directory
for filename in $DIRECTORY/*; do
    # Extract the filename without the directory path
    filename=$(basename "$filename")

    echo $filename
    # Create a commit message with the filename
    #commit_message="Added file: $filename"

    # Commit the changes with the generated message
    #git commit -m "$commit_message" -- "$filename"*/
done
