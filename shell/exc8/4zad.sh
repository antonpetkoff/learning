#!/bin/bash

# $1=dir with files and dirs
# $2=file to which to append directories which are nested in $1

find $1 -maxdepth 1 | while read file; do
    if [ -f "$file" ]; then
        wc -c $file
    elif [ -d "$file" ]; then
        echo $file >> $2
    fi
done

