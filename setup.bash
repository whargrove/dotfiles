#!/bin/bash

# Create ignores array because we don't want to symlink these to ~
ignores=(".git" "setup.bash" "LICENSE" "README.md")
# Create files array to store file names
files=()

# Include hidden files in glob
shopt -s dotglob

for entry in *
do
  files+=($entry);
done

# Remove hidden files in glob
shopt -u dotglob

for f in "${files[@]}"
do
  # If $f matches any ignores
  # Skip this loop iteration
  should_be_ignored=false
  for i in "${ignores[@]}"
  do
    if [ $f = $i ]; then
      $should_be_ignored=true
      break
    fi
  done

  if $should_be_ignored ; then
    continue
  fi

  # If $f already exists in the user's home directory
  # Rename the file before creating the symlink
  if [ -f ~/$f ]; then
    mv ../$f ../$f.old
  fi

  # Create symlink: source $f, target: ~/$f
  current_dir=$(pwd)
  ln -s $current_dir/$f ~/$f
done
