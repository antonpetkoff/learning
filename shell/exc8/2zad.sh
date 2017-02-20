#!/bin/bash

for f in $@
do
    if [ -f $f -a -r $f ]
    then echo "$f is a readable file"
    elif [ -d $f ]
    then find -type f -exec du -b {} \; | while read line
        do if [ $(echo $line | awk '{print $1}') -lt $(ls $f | wc -w) ]
            then echo $line | awk '{print $2}'
            fi
        done
    fi
done
