#!/bin/bash
# wrdict.sh word [french|english]: 
# inspect dictionary and opens wordreference page
LANG_DIR=/usr/share/dict
BROWSER=dillo

ENGLISH="american-english#www.wordreference.com/es/translation.asp?tranword="
FRENCH="french#www.wordreference.com/fres/"
SPANISH="spanish#www.wordreference.com/esfr/#www.wordreference.com/es/en/translation.asp?spen="
LANGS="$ENGLISH $FRENCH $SPANISH"
## MAIN

WORD=$1
DESTLANG=$2

if [ "$WORD" = "" ]; then
	echo "usage: $(basename $0) word"
	exit 1
fi

for LANG in $LANGS; do
	FILE=$(echo $LANG | cut -d# -f1)
	WEB=$(echo $LANG | cut -d# -f2)
	if [ "$FILE" = "spanish" -a "$DESTLANG" = "english" ]; then 
		WEB=$(echo $LANG | cut -d# -f3)
	fi
	if grep "^$WORD$" $LANG_DIR/$FILE &>/dev/null; then	
		$BROWSER "${WEB}${WORD}" &
	fi
done
exit 0
	
