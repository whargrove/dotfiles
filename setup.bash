#!/bin/bash

echo "** Getting ready to setup your .dotfiles ..."

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

echo "** Starting files loop"
for f in "${files[@]}"
do
  echo "** Checking if file: $f should be ignored ..."
  # If $f matches any ignores
  # Skip this loop iteration
  should_be_ignored=false
  for i in "${ignores[@]}"
  do
    if [ $f = $i ]; then
      unset should_be_ignored
      should_be_ignored=true
      echo "** File: $f will be ignored"
      break
    fi
  done

  if $should_be_ignored ; then
    echo "** File: $f has been ignored"
    continue
  fi

  echo "** File: $f is not ignored"
  echo "** Checking if file: $f already exists in ~ and should be backed up ..."
  # If $f already exists in the user's home directory
  # Rename the file before creating the symlink
  if [ -f ~/$f ]; then
    mv ~/$f ~/$f.old
    echo "** File: $f already exists in ~ and has been backed up"
  fi

  echo "** Creating symlink for file: $f"
  # Create symlink: source $f, target: ~/$f
  current_dir=$(pwd)
  ln -s $current_dir/$f ~/$f
done
