#!/bin/bash
logger "word.sh: Running"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

FILE=${1:-"$SCRIPT_DIR/../data/words.json"}
if [ -z $FILE ]
then
    FILE=$EXE
fi
COUNT="${2:-3}"
NOTIFY="${3:-false}"

echo "NOTE: requires jq and notify-send"

# get json blob
logger "word.sh: reading file $FILE"
FILE_TEXT=$(<$FILE)
WORDS=($( echo $FILE_TEXT | jq "keys_unsorted | .[]" | shuf -n $COUNT ))

# PRINT EACH WORD AND ITS DEF
JSON="{"
for WORD in ${WORDS[@]}; do
    DEF=$( echo $FILE_TEXT | jq -c ".$WORD" )
    JSON+="\"$WORD\" : \"$DEF\","
    if [ $NOTIFY ]; then
        notify-send -u critical -t 0 'WORD OF THE DAY' "$WORD : $DEF"
    fi
done
JSON+="}"

echo "$JSON"
logger "word.sh: Complete"
