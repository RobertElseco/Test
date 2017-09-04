#!/bin/bash

# Dagelijkse test
# RBo 23-08-2017

data=home/elseco/data.d

curl_naam=$(</$data/curl_naam)
curl_ww=$(</$data/curl_ww)
https_adres=$(</$data/https_adres)
idcode=$(</$data/id.device)

mess="alive --data @/home/elseco/data.d/status.json"

curl -X POST -u $curl_naam:$curl_ww $https_adres/$idcode/messages/?type=$mess

