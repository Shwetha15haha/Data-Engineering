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

echo "Listing Specific File Details (Replace 'file_name' with actual file name):"
ls -l new.txt

echo "Creating a Directory (Replace 'dir_name' with actual directory name):"
mkdir new

echo "Removing a File (Replace 'file_name' with actual file name):"
rm -f new.txt

echo "Removing a Directory (Replace 'dir_name' with actual directory name):"
rm -r new

echo "Changing Directory (Parent directory):"
cd ..

# echo "Displaying Manual Page for a Command (Replace 'command' with actual command):"
# man ls