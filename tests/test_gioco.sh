#!/bin/bash

source lib/map.sh
source lib/ui.sh
source lib/music.sh
source lib/story.sh
source lib/loot.sh
source lib/inventory.sh

inizializza_mappa
inizializza_pool_oggetti

introduzione

> saves/inventory.txt

while true
do
	mostra_stanza_corrente

	read -rn1 scelta

	case "$scelta" in

		q|Q)
			ferma_musica
			break
			;;

		e|E)
			if [ "${stanza_esplorata[$stanza_corrente]}" = "true" ]; then
				echo
				echo "Hai già trovato tutto ciò che era nascosto qui."
				echo

				read -r -p "Premi INVIO per continuare..."
			else
				esplora_stanza
			fi
			;;

		i|I)
			mostra_inventario
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
