#!/bin/bash

tira_dado() {
	echo $((RANDOM % 6 + 1))
}

combatti() {
	nemico_nome="$1"
	nemico_vita="$2"
	nemico_difesa="$3"
	nemico_danno="$4"

	echo

	echo "================================"
	echo "Hai incontrato: $nemico_nome"
	echo "================================"
	
	while [ "$personaggio_vita" -gt 0 ] && [ "$nemico_vita" -gt 0 ]
	do
		echo
		echo "Vita di $personaggio_nome: $personaggio_vita"
		echo "Vita di $nemico_nome: $nemico_vita"
		echo
		echo "1) Attacca"
		echo "2) Fuggi"

		read -p "Scegli un'azione: " azione

		if [ "$azione" = "1" ]; then
			dado=$(tira_dado)
			totale_attacco=$((personaggio_attacco + dado))
			
			echo
			echo "Risultato del dado: $dado"
			echo "Attacco totale: $personaggio_attacco + $dado = $totale_attacco"
			echo "Difesa del nemico: $nemico_difesa"
			
			if [ "$totale_attacco" -ge "$nemico_difesa" ]; then
				nemico_vita=$((nemico_vita - personaggio_danno))
				if [ "$nemico_vita" -le 0 ]; then
					nemico_vita=0
				fi
				
				echo
				echo "Attacco riuscito!"
				echo "$nemico_nome subisce $personaggio_danno danni."
			else
				personaggio_vita=$((personaggio_vita - nemico_danno))
				
				if [ "$personaggio_vita" -le 0 ]; then
					personaggio_vita=0
				fi

				echo
				echo "Attacco fallito!"
				echo "$personaggio_nome subisce $nemico_danno danni."
			fi
		
		elif [ "$azione" = "2" ]; then
			echo
			echo "Sei fuggito dal combattimento."
			return 2
		else
			echo
			echo "Scelta non valida: inserisci 1 oppure 2."
		fi
	done

	if [ "$nemico_vita" -le 0 ]; then
		echo
		echo "Hai sconfitto $nemico_nome!"
		return 0
	fi
	
	if [ "$personaggio_vita" -le 0 ]; then
		echo 
		echo "$personaggio_nome è stato sconfitto."
		return 1
	fi
}
