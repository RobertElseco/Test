#!/bin/sh

# Stop notatie status.json

datum="$(date +"%X %d-%m-%y")"

cat >>/home/elseco/data.d/status.json <<EOL
   "Systeemtijd en -datum": "$datum"
}
EOL
