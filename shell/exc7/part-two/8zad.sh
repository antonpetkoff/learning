#!/bin/bash

# $1=source, $2=dest

i=0

find $1 -maxdepth 1 -type f | while read line; do 
    if [ -r $line ]; then
        cp $line $2
        echo $i
        i=$(($i + 1))
        echo $i
    fi
done

echo "$i files copied from $1 to $2"
