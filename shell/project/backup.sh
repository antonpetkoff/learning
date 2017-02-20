#!/bin/bash

# we backup only /home/team2/
# $1 is the source-machine

# create lockfile
cat backup_config | while read line
do
    rsync -va --progress $line ~/backup_data/TODO: >> ~/backup_data/backup_log
done
# delete lockfile

