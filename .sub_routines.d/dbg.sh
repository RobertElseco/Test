#!/bin/bash

stops=0

for line in `cat ~/dbg-tabel | grep -v ^#`; do

((stops+=1))

IFS=-
set $line
((dec=$1))
((bin=$2))
((gray=$3))

((dec$stops=$dec))
((bin$stops=$bin))
((gray$stops=$gray))

done

for (( i=1; i<$stops+1; i++ ));
do
	eval dec=( \${dec$i} )
        eval bin=( \${bin$i} )
        eval gray=( \${gray$i} )
	echo "$dec Decimaal, is $bin Binair en $gray Graycode"
done

