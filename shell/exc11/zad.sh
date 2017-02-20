#!/bin/bash

ps -e -o user,pri | tail -n +2 | sort | uniq -c | while read line
do
    if [ $(echo $line | cut -d' ' -f1) -gt 8 ]
    then echo $line
    fi
done

