#!/bin/bash

# $1=username, $2=logfile
# kill all processes started by $1 and write the number of the started process by $1 in stdout

i=0

cat $2 | tail -n $(($(cat log | wc -l) - 1)) | grep -E "^$1 " | while read line
do
    i=$(($i + 1))
    kill -9 $(echo $line | cut -d' ' -f2)
done

echo "$i processes were started by user $1"

