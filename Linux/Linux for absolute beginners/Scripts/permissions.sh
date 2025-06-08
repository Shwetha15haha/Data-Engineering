#!/bin/bash
# Basic Linux Commands Script
#!/bin/bash

# List existing files and directories
echo "Listing files and directories:"
ls -l

# Create a new directory and file
echo "Creating a new directory 'test_dir' and a file 'test_file.txt'"
mkdir test_dir
touch test_dir/test_file.txt

# Display the permissions
echo "Permissions after creation:"
ls -l test_dir

# Change permissions using symbolic notation
echo "Changing permissions using symbolic notation:"
chmod u+rwx,g+rx,o+r test_dir/test_file.txt
# ugo+rwx or ugo-rwx format
ls -l test_dir

# Change permissions using numeric notation
echo "Changing permissions using numeric notation:"
chmod 755 test_dir/test_file.txt
# refer 0 to 7 permission list 
ls -l test_dir

# Additional permission modifications
echo "Removing write permission for group and others:"
chmod go-w test_dir/test_file.txt
ls -l test_dir

echo "Setting full permissions for the user and read-only for others:"
chmod 744 test_dir/test_file.txt
ls -l test_dir

# Clean up: Removing created directory and file
echo "Removing test_dir and its contents"
rm -rf test_dir

# check manual
# man chmod