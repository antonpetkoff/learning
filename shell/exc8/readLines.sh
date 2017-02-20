#!/bin/bash

i=0

while read line
do
    i=$(($i + 1))
    echo $line
done < $1

echo $i
