#!/bin/bash
# Basic Linux Commands Script

echo "Current User:"
whoami

echo "Current Working Directory:"
pwd

echo "Listing Files:"
ls

echo "Listing Files in Long Format:"
ls -l

echo "Listing Files Sorted by Modification Time (Reverse Order):"
ls -ltr

echo "Create a new file:"
touch new.txt

echo "Listing Specific File Details:"
ls -l new.txt

echo "Creating a Directory:"
mkdir new

echo "Removing a File:"
rm -f new.txt

echo "Removing a Directory:"
rm -r new

echo "Changing Directory (Parent directory):"
cd ..

# echo "Displaying Manual Page for a Command (Replace 'command' with actual command):"
# man ls