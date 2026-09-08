#!/bin/bash

torcia=0
echo "Benvenuto nel dungeon!"

read -p "Come ti chiami? " nome

while true
do
	echo
	echo "===== DUNGEON ====="
	echo "1) Esplora"
	echo "2) Controlla inventario"
	echo "3) Esci"

	read -p "Scelta: " scelta

	if [ "$scelta" = "1" ]; then
		echo "Inizia l'esplorazione..."
		
		if [ "$torcia" = "1" ]; then
			echo "Hai già raccolto la torcia."
		fi
		
		if [ "$torcia" = "0" ]; then
			echo "Trovi una torcia!"
			torcia=1
		fi
	fi

	if [ "$scelta" = "2" ]; then
		echo "Il tuo inventario è vuoto"
	fi
	
	if [ "$scelta" = "3" ]; then
		echo "Arrivederci $nome!"
		break
	fi
done
