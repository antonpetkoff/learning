#!/bin/bash

# $1 is a log file for non-existent files

if [ $# -eq 0 ]; then exit; fi

logFile=$1
shift

for f in $@; do
    if [ -e $f ]; then
        cat $f | head -n 1 | cut -c1-2
    else
        echo $f >> $1
    fi
done
