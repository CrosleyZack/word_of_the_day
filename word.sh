#!/bin/bash
logger "word.sh: Running"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
EXE="$SCRIPT_DIR/word.json"

FILE=$1
if [ -z $FILE ]
then
    FILE=$EXE
fi
COUNT="${2:-1}"

# get json blob
# TODO update
logger "meditation.sh: reading file $FILE"
FILE_TEXT=$(<$FILE)
JQ_SELECTOR=".[]"
IFS=$'\n'
THIS_JSON=($( echo $FILE_TEXT | jq -c "$JQ_SELECTOR" | shuf -n $COUNT ))

# send notifications
logger "word.sh: Sending words $THIS_JSON"
for OUTPUT in ${THIS_JSON[@]}; do
    notify-send -u critical -t 0 'Word of the Day' "$OUTPUT"
done

logger "word.sh: Complete"
