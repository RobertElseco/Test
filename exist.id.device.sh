# exist.id.device 2017-07-17 RBo
# Controleer of id.device bestaat

if [[ -f id.device ]]
then

  clear
  echo
  echo -n "ID.Device bestaat al."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo "."; sleep .5
  adjust.id.device.sh

else

  clear
  echo
  echo -n "ID.Device bestaat nog niet, wordt aangemaakt."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo -n "."; sleep .5
  echo "."; sleep .5
  create.id.device.sh

fi
