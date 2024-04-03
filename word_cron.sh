#!/bin/bash

# How often to run. default to every four hours
HOUR="${1:-4}"
# What minute to run at, generate randomly if not specified
MIN=$2
if [ -z "$MIN" ]
then
    MIN=$(($RANDOM % 60))
fi

# Get executable to run
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "mediatation_cron SCRIPT_DIR = $SCRIPT_DIR"
logger "meditation_cron SCRIPT_DIR = $SCRIPT_DIR"
EXE="$SCRIPT_DIR/meditation.sh"

# run meditation script _now_
bash $EXE

# Add new cronjob if doesn't already exist
# sh crontab -e
crontab -l > crontab_new
found=$( grep $EXE crontab_new )
if [ -z "$found" ]
then
    echo "meditation_cron adding cron to crontab every $HOUR at $MIN minutes"
    logger "meditation_cron adding cron to crontab every $HOUR at $MIN minutes"
    echo "$MIN */$HOUR * * * $EXE" >> crontab_new
fi
crontab crontab_new
rm crontab_new
