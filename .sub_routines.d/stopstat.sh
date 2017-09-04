#!/bin/sh

# Start notatie status.json

datum="$(date +"%X %d-%m-%y")"

cat >>/home/elseco/data.d/status.json <<EOL
   "Systeemtijd": "$datum"
}
EOL
