#!/bin/bash

inizializza_mappa() {
	
	declare -gA mappa
	
	mappa["Ingresso"]="Sala"
	mappa["Sala"]="Ingresso Armeria Biblioteca"
	mappa["Armeria"]="Sala" 
	mappa["Biblioteca"]="Sala Torre"
	mappa["Torre"]="Biblioteca"

	stanza_corrente="Ingresso"

}

mostra_uscite() {
	
	echo
	echo "Porte disponibili:"

	numero_porta=1
	
	for destinazione in ${mappa[$stanza_corrente]}
	do
		echo "$numero_porta) $destinazione"
		numero_porta=$((numero_porta + 1))
	done
}

cambia_stanza() {

	destinazioni=(${mappa[$stanza_corrente]})

	indice=$((scelta - 1))

	if [ "$indice" -ge 0 ] && [ "$indice" -lt "${#destinazioni[@]}" ]; then
		stanza_corrente="${destinazioni[$indice]}"
	fi	
}
