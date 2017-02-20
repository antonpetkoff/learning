#!/bin/bash

echo "Enter folder name:"
read folderName
mkdir "/home/tony/${folderName}"

find $1 -maxdepth 1 -type f | while read file; do
    if [ -r $file -a -w $file ]; then
        cp $file "/home/tony/$folderName"
    fi
done

