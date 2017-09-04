#!/bin/bash

# Communicatie naar callcenter door middel van input GPIO #132
# RBo 17-08-2017

# sudo sh -c 'echo 132 > /sys/class/gpio/export'
# while ( true ); do cat /sys/class/gpio/gpio132/value; sleep 1; done;
# curl -v -X POST -u 'xxxxx.xxxxx@xxxxx.xxx:xxxxxxxx' https://xxx.xxxxx.xxx/api/v1/receivers/xxxxxxxx/messages/?type=emergency
# curl -X POST -u $curl_naam:$curl_ww $https_adres/$idcode/messages/?type=emergency

# Tijdinstellingen
alarmknop=0
tijd_ak=0
vertraging_tijd_ak=5
stuck_ak=0
tijd_stuck_ak=10
gemeld_stuck_ak=0
monalarm=" "

data=home/elseco/data.d
echo "$monalarm" > /home/elseco/ramdisk.d/monalarm

curl_naam=$(</$data/curl_naam)
curl_ww=$(</$data/curl_ww)
https_adres=$(</$data/https_adres)
idcode=$(</$data/id.device)

while ( true )
do GPIO132=$(</sys/class/gpio/gpio132/value)

sleep .5

if [[ $alarmknop -eq 0 ]]

then
        monalarm="Alarmknop niet ingedrukt"
fi

if [[ $GPIO132 -eq 1 ]]

then
        ((tijd_ak+=1))
	if [[ $alarmknop -eq 0 ]]

        then
                monalarm="Alarmknop ingedrukt"
		alarmknop=1
        else
                monalarm="Alarmknop "$tijd_ak" sec ingedrukt"
        fi

else
        if [[ $alarmknop -eq 1 ]]

        then
                monalarm="Alarmknop weer losgelaten"

		if [[ $gemeld_stuck_ak -gt 0 ]]

		then
			curl -X POST -u $curl_naam:$curl_ww $https_adres/$idcode/messages/?type=emergency_button_ok
			echo
		        monalarm="CURL STUCK HERSTELD CURL STUCK HERSTELD"
                        alarmknop=0; tijd_ak=0; stuck_ak=0; gemeld_stuck_ak=0
		else
			alarmknop=0; tijd_ak=0; stuck_ak=0; gemeld_stuck_ak=0
		fi
        fi

fi

if [[ $tijd_ak -eq $vertraging_tijd_ak ]]

then
	curl -X POST -u $curl_naam:$curl_ww $https_adres/$idcode/messages/?type=emergency
	echo
#	monalarm="Noodoproep geplaatst"
	monalarm="CURL DRUKKNOP CURL DRUKKNOP"
#       ((tijd_ak+=1)); # tijd_ak + 1 hier waarschijnlijk niet nodig
fi

if [[ $tijd_ak -gt $vertraging_tijd_ak ]]

then
        monalarm="Alarmknop "$tijd_ak" sec ingedrukt"
	((stuck_ak+=1))
fi

if [[ $gemeld_stuck_ak -gt 1 ]]

then
        monalarm="Alarmknop blijft al "$tijd_ak" sec hangen"
        ((gemeld_stuck_ak+=1))
fi

if [[ $gemeld_stuck_ak -eq 1 ]]

then
	echo
	curl -X POST -u $curl_naam:$curl_ww $https_adres/$idcode/messages/?type=emergency_button_failure
	monalarm="CURL STUCK CURL STUCK"
	((gemeld_stuck_ak+=1))
fi

if [[ $stuck_ak -eq $tijd_stuck_ak ]]

then
        monalarm="Alarmknop blijft hangen, doorgemeld"
        ((gemeld_stuck_ak+=1))
fi

echo "$monalarm" > ~/ramdisk.d/monalarm
# echo "$monalarm"

done
