#!/bin/bash
logger "word.sh: Running"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
EXE="$SCRIPT_DIR/words.json"

FILE=$1
if [ -z $FILE ]
then
    FILE=$EXE
fi
COUNT="${2:-1}"

# get json blob
logger "word.sh: reading file $FILE"
FILE_TEXT=$(<$FILE)
WORDS=($( echo $FILE_TEXT | jq "keys_unsorted | .[]" | shuf -n $COUNT ))

# PRINT EACH WORD AND ITS DEF
for WORD in ${WORDS[@]}; do
    DEF=$( echo $FILE_TEXT | jq -c ".$WORD" )
    OUTPUT="$WORD  :  $DEF"
    logger "word.sh: displaying $OUTPUT"
    notify-send -u critical -t 0 'WORD OF THE DAY' "$OUTPUT"
done

logger "word.sh: Complete"
