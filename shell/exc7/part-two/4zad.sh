#!/bin/bash

# $1=b, $2=x, $3=a

if [ $2 -ge $3 -a $2 -le $1 ]
then echo "$2 is in [$3, $1]"
else echo "$2 is NOT in [$3, $1]"
fi
