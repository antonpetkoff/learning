#!/bin/bash

# functions have their own $1, ..., $n arguments
function printLetters {
    echo $1 | grep -o . | while read letter
       do echo $letter
    done
}

function prompt {
    msg="Enter a string of length greater than 5:"
    echo $msg
    read s
    printLetters $s
}

prompt

while [ $(expr length $s) -le 5 ]   # you can also use ${#s} to find out the length of $s
    do prompt
done

echo "Third letter = $(echo $s | grep -o . | head -n 3 | tail -n 1)"
