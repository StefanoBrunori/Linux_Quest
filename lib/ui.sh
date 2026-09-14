#!/bin/bash

mostra_testo() {
	clear
	
	cat assets/immagini/castello.png
	local testo="$1"

	echo "+----------------------------------------------------------+"
	echo "| 		  					   |"
	printf "| %-56s |\n" "$testo"
	echo "| 		  					   |"
	echo "+----------------------------------------------------------+"
	echo

	read -p "Premi INVIO per continuare..."
}
