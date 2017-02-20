#!/bin/bash

# $1 = dir, $2 = fileSize

if [ -d $1 -a -e $1 ]
then find $1 -maxdepth 1 -type f -exec du -b {} \; | while read line
    do
        if [ $(echo $line | awk '{print $1}') -gt "$2" ]
        then echo $line | awk '{print $2}'
        fi
    done
else echo "error: $1 is not a directory!"
fi
