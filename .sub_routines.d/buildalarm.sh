#!/bin/bash

# Samenstellen alarm.json

subr=home/elseco/.sub_routines.d
data=home/elseco/data.d

rm -f /$data/alarm.json

/$subr/startalarm.sh $
wait
/$subr/alarmtijd.sh $
wait
/$subr/stopalarm.sh

