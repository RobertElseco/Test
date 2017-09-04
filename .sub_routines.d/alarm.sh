#!/bin/bash

# Doormelding gegevens noodoproep
# RBo 04-09-2017

data=home/elseco/data.d

curl_naam=$(</$data/curl_naam)
curl_ww=$(</$data/curl_ww)
https_adres=$(</$data/https_adres)
idcode=$(</$data/id.device)

mess="emergency --data @/home/elseco/data.d/alarm.json"

curl -X POST -u $curl_naam:$curl_ww $https_adres/$idcode/messages/?type=$mess

