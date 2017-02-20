#!/bin/bash

echo "Enter two integers a and b which determine [a, b]:"
read a b

for i in $@
do
    if [ $i -ge $a -a $i -le $b ]
    then echo "$(($i * $i))"
    fi
done
