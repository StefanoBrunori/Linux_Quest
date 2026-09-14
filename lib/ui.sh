#!/bin/bash

mostra_testo() {
	
	local testo="$1"

	clear

	echo "+----------------------------------------------------------+"
	echo "| 		  					   |"
	printf "| %-56s |\n" "$testo"
	echo "| 		  					   |"
	echo "+----------------------------------------------------------+"
	echo
	read -p "Premi INVIO per continuare..."
}
