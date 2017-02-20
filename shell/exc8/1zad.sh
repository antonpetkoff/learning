#!/bin/bash

for f in $@
do mv $f "$(echo $f | cut -d'.' -f 1).otf"
done

asdsd
