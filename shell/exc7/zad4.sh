#!/bin/bash

echo "Enter search phrase:"
read phrase

for l in $@; do
    echo "$(cat $l | grep -c $phrase) occurrences of $phrase in $l"
done

