#!/bin/bash

# $1=filename $2=string

count=$(grep -c $2 $1)

if [ $count -ge 15 -a $count -le 35 ]
then echo "$1 contains $2 on  lines"
fi
