#!/bin/bash

declare -A mappa

mappa["Ingresso"]="Sala"
mappa["Sala"]="Ingresso Armeria Biblioteca"
mappa["Armeria"]="Sala"
mappa["Biblioteca"]="Sala Torre"
mappa["Torre"]="Biblioteca"

stanza_corrente="Ingresso"

while true
do
	clear
	
	echo "======================"
	echo " LINUX QUEST"
	echo "======================"
	echo
	echo "Posizione: $stanza_corrente"
	echo
	echo "Porte disponibili:"
	
	numero_porta=1

	for destinazione in ${mappa[$stanza_corrente]}
	do
		echo "$numero_porta) $destinazione"
		numero_porta=$((numero_porta + 1))
	done

	echo "0) Termina il gioco"
	echo

	read -p "Scegli una porta: " scelta
	
	if [ "$scelta" = "0" ]; then
		echo "Fine dell'avventura."
		break
	fi

	destinazioni=(${mappa[$stanza_corrente]})
	indice=$((scelta - 1))
	
	if [ "$indice" -ge 0 ] && [ "$indice" -lt "${#destinazioni[@]}" ]; then
		stanza_corrente="${destinazioni[$indice]}"
	else
		echo "Quella porta non esiste."
		read -p "Premi Invio per continuare..."
	fi
done
