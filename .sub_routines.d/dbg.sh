#!/bin/bash

stops=0

for line in `cat ~/data.d/bg-tabel | grep -v ^#`; do

((stops+=1))

IFS=-
set $line
((stoppl=$1))
((waarde=$2))

((stoppl$stops=$stoppl))
((waarde$stops=$waarde))

done

for (( i=1; i<$stops+1; i++ ));
do
	eval stoppl=( \${stoppl$i} )
        eval waarde=( \${waarde$i} )
	echo "Stopplaats $stoppl, is waarde $waarde"
done

