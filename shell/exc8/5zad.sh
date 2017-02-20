#!/bin/bash

function countOut {
    ls $1 | grep '\.out$' | wc -l
}

if [ $(countOut $1) -gt $(countOut $2) ]; then
    echo "$1 has more files of the type .out than $2"
fi

