#!/bin/bash

killmon &
wait

/home/elseco/.sub_routines.d/monitoring1.sh &
# /home/elseco/.sub_routines.d/monitoring2.sh &

while ( true )

do
	echo "$(<~/ramdisk.d/monalarm)"
#	echo "$(<~/ramdisk.d/monalarm) en $(<~/ramdisk.d/monstor)"
	sleep .5
done
