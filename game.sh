#!/bin/bash

source lib/map.sh

inizializza_mappa
echo "${mappa["ingresso"]}"

while true
do
	clear

	echo
	echo "Stanza attuale: $stanza_corrente"

	mostra_uscite

	echo
	echo "0) Esci"

	read -p "Scelta: " scelta

	if [ "$scelta" = "0" ]; then
		echo "Arrivederci!"
		break
	fi

	cambia_stanza
done
	
