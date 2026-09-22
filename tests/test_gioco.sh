#!/bin/bash

source lib/map.sh
source lib/ui.sh
source lib/music.sh
source lib/story.sh

inizializza_mappa

introduzione

while true
do
	mostra_stanza_corrente

	echo
	echo "M) Mappa visitata"
	echo "D) Debug mappa completa"
	echo "Q) Esci"
	echo

	read -r -p "Scelta: " scelta
	echo "$scelta"
	
	case "$scelta" in
	
		q|Q)
			ferma_musica
			break
			;;
		
		m|M)
			mostra_mappa_visitata
		        ;;

		d|D)
			mostra_mappa_completa
			;;
		
		*)
			cambia_stanza
			;;
	esac
done
