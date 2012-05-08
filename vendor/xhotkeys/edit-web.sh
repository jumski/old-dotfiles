#!/bin/bash
DIR=webpage/xhotkeys
FILES="index-template.html
howtouse-template.html
contact-template.html
tokland.css"
EDITOR=bluefish

(cd $DIR; $EDITOR $FILES) &
exit 0
