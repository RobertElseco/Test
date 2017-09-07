#!/bin/bash

# Communicatie naar callcenter door middel van input GPIO #136/137/138/139
# Funtie Positie liftkooi monitoren
# RBo 07-09-2017

positie=" "
monpos=" "

while ( true )
do
	GPIO136=$(</sys/class/gpio/gpio136/value)
	GPIO137=$(</sys/class/gpio/gpio137/value)
	GPIO138=$(</sys/class/gpio/gpio138/value)
	GPIO139=$(</sys/class/gpio/gpio139/value)

sleep 1

positie="$GPIO139$GPIO138$GPIO137$GPIO136"



echo "$monpos" > ~/ramdisk.d/monpos

done

