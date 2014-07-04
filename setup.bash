#!/usr/local/bin/bash

# Create ignores
# .git
# setup.bash
# LICENSE
# README.md

# Loop through all files in .
  # if ./$file_name matches any ignores
    # continue loop
  # if ../$file_name already exists
    # rename file to $file_name.old
  # symlink ./$file_name to $../$file_name
