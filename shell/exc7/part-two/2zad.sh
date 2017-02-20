#!/bin/bash

for i in $@
do
    if [ $i -ge 5 -a $i -lt 105 ]
    then echo "$(($i * $i))"
    fi
done
