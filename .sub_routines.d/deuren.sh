#!/bin/sh

# Aanvulling status.json tbv ritten per verdieping

stop1="Kelder"
stop2="Begane grond"
stop3="1e verdieping"
stop4="2e verdieping"
stop5="3e verdieping"

ritstop1=32
ritstop2=3
ritstop3=12
ritstop4=11
ritstop5=26

ritten=21543
ritten24=78

cat >>/home/elseco/data.d/status.json <<EOL
   "Totaal aantal ritten sinds start": "$ritten ritten",
   "Ritten en deurbewegingen sinds laatste melding": "$ritten24 ritten",
   "$stop1": "$ritstop1",
   "$stop2": "$ritstop2",
   "$stop3": "$ritstop3",
   "$stop4": "$ritstop4",
   "$stop5": "$ritstop5",
EOL
