#!/bin/bash

# Funtie Wegschrijven start-/stoptijd en tijdsduur alarmoproep naar alarm.json
# RBo 14-09-2017

# ramdisk=home/elseco/ramdisk.d

# starta==$(</$ramdisk/starta)
# stop==$(</$ramdisk/stop)
# alarmduur==$(</$ramdisk/alarmduur)
starta="23:12:16"
stopa="23:13:39"
alarmduur="00:01:23"

cat >>/home/elseco/data.d/alarm.json <<EOL
   "Starttijd alarmoproep": "$starta",
   "Stoptijd alarmoproep": "$stopa",
   "Totale gespreksduur": "$alarmduur",
EOL
