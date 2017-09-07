#!/bin/bash

# Dit script kopieert de juiste tabel tbv de standaanwijzer naar bg-tabel

SETVAR=type
unset type

type=$(<~/data.d/typestaw)

# 1 is Binair
if [[ $type -eq 1 ]]

then
	echo "# Kopie btabel" > ~/data.d/bg-tabel
	cat ~/btabel >> ~/data.d/bg-tabel

# 2 is Graycode
elif [[ $type -eq 2 ]]

then
	echo "# Kopie gtabel" > ~/data.d/bg-tabel
	cat ~/gtabel >> ~/data.d/bg-tabel

else
	echo "Onjuiste instelling type standaanwijzer (Binair/Graycode)"

fi
