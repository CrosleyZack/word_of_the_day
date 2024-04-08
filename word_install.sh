#!/bin/bash

# NOTE: requires jq and notify-send

FILE_PATH=$(realpath $BASH_SOURCE)
# echo "FILE_PATH = $FILE_PATH"
DIR_PATH=$(dirname $FILE_PATH)
# echo "DIR_PATH = $DIR_PATH"

# Create startup.desktop
DESKTOP_FILE="$DIR_PATH/word.desktop"
rm -f $DESKTOP_FILE
echo "[Desktop Entry]
Type=Application
Name=WordOfTheDayScript
Exec=$DIR_PATH/word_cron.sh
OnlyShowIn=GNOME;" > $DESKTOP_FILE

# link to generated startup script.
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p $XDG_CONFIG_HOME/autostart
rm -f $XDG_CONFIG_HOME/autostart/word.desktop
ln -s $DESKTOP_FILE $XDG_CONFIG_HOME/autostart/word.desktop
echo "word of the day installed"
