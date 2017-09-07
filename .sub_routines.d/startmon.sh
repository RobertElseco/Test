#!/bin/bash

killmon &
wait

# /home/elseco/.sub_routines.d/monitoring1.sh &
# /home/elseco/.sub_routines.d/monitoring2.sh &
/home/elseco/.sub_routines.d/monitoring3.sh &

while ( true )

do
#	echo "$(<~/ramdisk.d/monalarm)"
#	echo "$(<~/ramdisk.d/monstor)"
	echo "Stopplaats $(<~/ramdisk.d/monpos)"
#	echo "$(<~/ramdisk.d/monalarm) en $(<~/ramdisk.d/monstor), op stopplaats $(<~/ramdisk.d/monpos)"
	sleep .5
done
