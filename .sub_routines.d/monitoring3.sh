#!/bin/bash

# Communicatie naar callcenter door middel van input GPIO #134/135
# Funtie Gespreksstatus monitoren
# RBo 14-09-2017


# STRINGS HIERONDER NOG HERNOEMEN!!!

storingscontact=1
vertraging_sc_tijd=10
vertraging_sc=vertraging_sc_tijd
monstor=" "
echo "$monstor" > ~/ramdisk.d/monstor

while ( true )
do GPIO133=$(</sys/class/gpio/gpio133/value)

sleep .5

if [[ $storingscontact -eq 1 ]]

then
        monstor="Storingscontact is gesloten"

fi

if [[ $GPIO133 -eq 0 ]]

then
        if [[ $storingscontact -eq 1 ]]

        then
                monstor="Storingscontact is verbroken"; storingscontact=0; ((vertraging_sc-=1))
        else
                monstor="Storingscontact nog steeds verbroken"; ((vertraging_sc-=1))
        fi

else
        if [[ $storingscontact -eq 0 ]]

        then
                monstor="Storingscontact weer gesloten"; storingscontact=1; vertraging_sc=vertraging_sc_tijd
        fi

fi

if [[ $vertraging_sc -eq 0 ]]

then
        monstor="Storing doorgemeld"

fi

echo "$monstor" > ~/ramdisk.d/monstor

done
