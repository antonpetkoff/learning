#!/bin/bash

if [ $# -eq 0 ]
then echo "No parameters given!"; exit
fi

count=$1
sum=0
shift

if [ $count -ne $# ]
then echo "Error: N=${count}, but $# parameters are given!"
else
    for i in $@
    do sum=$(($sum + $i))
    done
    echo $sum
fi

