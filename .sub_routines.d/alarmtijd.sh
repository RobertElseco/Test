#!/bin/sh

# Aanvulling alarm.json tbv start/stop tijd alarmoproep

# data=home/elseco/data.d

# starta==$(</$data/starta)
# stop==$(</$data/stop)
# alarmduur==$(</$data/alarmduur)
starta="23:12:16"
stopa="23:13:39"
alarmduur="00:01:23"

cat >>/home/elseco/data.d/alarm.json <<EOL
   "Starttijd alarmoproep": "$starta",
   "Stoptijd alarmoproep": "$stopa",
   "Totale gespreksduur": "$alarmduur",
EOL
