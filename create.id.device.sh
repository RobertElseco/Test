#!/bin/bash

# create.id.device 2017-07-27 RBo
# Bouwen van create.id.device

clear

unset nieuwid
unset idlength
unset idcode

if [[ -f id.device ]]

then
  echo; echo
  echo "Bestand id.device bestaat reeds, maar is leeg."

else
  echo; echo
  echo "" > id.device
  echo "Bestand id.device weg geschreven"

fi

echo; echo
echo -n "Voer een 8-cijferige ID-code in: "; read -n 8 nieuwid
idlength=${#nieuwid}

if [[ $nieuwid = "" ]]

then
  echo; echo
  echo -n "ID-code mag niet leeg zijn, opnieuw "; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo "."; sleep .5
  create.id.device

elif [[ $idlength -ne 8 ]]

then
  echo; echo
  echo -n "Onjuiste invoer, ID-code moet 8 cijfers lang zijn "
  echo -n "en niet $idlength "; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo "."; sleep .5
  create.id.device

else
  echo $nieuwid > id.device
  idcode=$(<id.device)
  echo; echo
  echo -n "Nieuw ID-nummer is: $idcode "; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo "."; sleep .5
  summary.id.device

fi

