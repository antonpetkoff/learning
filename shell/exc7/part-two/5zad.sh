#!/bin/bash

# $1=filename $2=string

echo "$1 contains $2 on $(grep -c $2 $1) lines"

