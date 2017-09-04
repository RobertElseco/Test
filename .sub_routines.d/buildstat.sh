#!/bin/bash

# Samenstellen status.json

subr=home/elseco/.sub_routines.d
data=home/elseco/data.d

rm -f /$data/status.json

/$subr/startstat.sh $
wait
/$subr/batterij.sh $
wait
/$subr/deuren.sh $
wait
/$subr/stopstat.sh

