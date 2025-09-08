#!/bin/bash

# How often to run. default to every 12 hours
HOUR="${1:-12}"
# What minute to run at, generate randomly if not specified
MIN=$2
if [ -z "$MIN" ]
then
    # 1 - 59
    MIN=$(( ( RANDOM % 58 )  + 1 ))
fi
# how many words
WORDS="${3:-3}"

# Get executable to run
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "word_cron SCRIPT_DIR = $SCRIPT_DIR"
logger "word_cron SCRIPT_DIR = $SCRIPT_DIR"
EXE="$SCRIPT_DIR/word.sh $SCRIPT_DIR/../data/words.json $WORDS true"

# Add new cronjob if doesn't already exist
# sh crontab -e
crontab -l > crontab_new
found=$( grep "$SCRIPT_DIR/word.sh" crontab_new )
if [ -z "$found" ]
then
    echo "word_cron adding cron to crontab every $HOUR at $MIN minutes"
    logger "word_cron adding cron to crontab every $HOUR at $MIN minutes"
    echo "$MIN */$HOUR * * * $EXE" >> crontab_new
fi
crontab crontab_new
rm crontab_new
