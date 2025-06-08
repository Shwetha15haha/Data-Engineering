#!/bin/bash

# Define variables
FILE="example.txt"
DIR="example_dir"
NEW_USER="developer"
NEW_GROUP="devs"

# check current directory
pwd

# change directory 
cd dir_name

# Create a sample file and directory
touch "$FILE"
mkdir "$DIR"

# Change file ownership
echo "Changing ownership of $FILE to $NEW_USER..."
chown "$NEW_USER:$NEW_GROUP" "$FILE"

# Change directory ownership
echo "Changing ownership of $DIR to $NEW_USER..."
chown "$NEW_USER:$NEW_GROUP" "$DIR"

# Change group ownership only
echo "Changing group ownership of $FILE to $NEW_GROUP..."
hgrp "$NEW_GROUP" "$FILE"

# Verify changes
echo "Updated ownership details:"
ls -l

# Additional
# help commands usage
whatis chown
chown --help
man chown