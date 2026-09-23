#!/bin/bash

source lib/map.sh
source lib/ui.sh
source lib/music.sh
source lib/story.sh
source lib/loot.sh

inizializza_mappa
inizializza_pool_oggetti

introduzione

while true
do
	mostra_stanza_corrente

	echo
	echo "E) Esplora stanza" 
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

		e|E)
			esplora_stanza
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
