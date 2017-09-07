#!/bin/bash

# adjust.id.device 2017-07-23 RBo
# Waarde id.device behouden of aanpassen

clear

unset idcode
unset nieuwid
unset idlength
data=home/elseco/data.d
subr=/home/elseco/.sub_routines.d

if [[ -s /$data/id.device ]]

then
  idcode=$(</$data/id.device)
  echo; echo
  echo "Huidige ID-code: $idcode"
  echo "Voor behouden, toets <ENTER>"
  echo -n "Of voer een nieuwe 8-cijferige ID-code in: "; read -n 8 nieuwid
  idlength=${#nieuwid}

  if [[ $nieuwid = "" ]]

  then
    echo; echo
    echo -n "Behouden"; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo "."; sleep .5
    /$subr/summary.id.device

  elif [[ $idlength -ne 8 ]]

  then
    echo; echo
    echo -n "Onjuiste invoer, ID-code moet 8 cijfers lang zijn "
    echo -n "en niet $idlength "; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo "."; sleep .5
    /$subr/adjust.id.device

  else
    echo $nieuwid > /$data/id.device
    idcode=$(</$data/id.device)
    echo; echo
    echo -n "Nieuw ID-nummer is: $idcode "; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo "."; sleep .5
    /$subr/summary.id.device

  fi

else
  echo; echo
  echo "ID-code nog niet ingevuld."
  echo
  echo -n "Nieuwe ID-code: "
  read nieuwid
  idlength=${#nieuwid}

  if [[ $idlength -ne 8 ]]

  then
    echo; echo
    echo -n "Onjuiste invoer, ID-code moet 8 cijfers lang zijn "
    echo -n "en niet $idlength "; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo "."; sleep .5
    /$subr/adjust.id.device

  else
    echo $nieuwid > /$data/id.device

    idcode=$(</$data/id.device)
    echo; echo
    echo -n "Nieuw ID-nummer is: $idcode "; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo -n "."; sleep .5
    echo "."; sleep .5
    /$subr/summary.id.device

  fi

fi
