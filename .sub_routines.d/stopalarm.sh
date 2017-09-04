#!/bin/sh

# Stop notatie alarm.json

datum="$(date +"%X %d-%m-%y")"

cat >>/home/elseco/data.d/alarm.json <<EOL
   "Systeemtijd en -datum": "$datum"
}
EOL
