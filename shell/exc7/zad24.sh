#!/bin/bash

function repeatChar {
    # $1=char $2=count
    for i in $(seq 1 $2); do echo -n "$1"; done
}

for i in $(seq $1 -1 1)
do echo "$(repeatChar ' ' $(($1 - $i))) $(repeatChar '*' $i)"
done
