#!/bin/bash


if [ $# -ne 2 ]
then echo "Error: enter 2 parameters!"
else echo $(($1 + $2))
fi
