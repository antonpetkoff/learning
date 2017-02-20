#!/bin/bash

while [ $(w | cut -d' ' -f1 | grep -e "$1") -eq 0 ]
do sleep
done
echo "user exists"
