#!/bin/bash

genera_mappa() {
	crea_stanze
	collega_stanze
	assegna_oggetti

	STANZA_CORRENTE="stanza_1"
}

crea_stanze() {
	
}

collega_stanze() {

}

assegna_oggetti() {

}


entra_nella_stanza() {
	local stanza="$1"

	STANZA_CORRENTE="$stanza"

	if [[ "${STANZA_NEMICO_GENERATO[$stanza]}" != "true" ]]; then
		genera_nemico "$stanza"
		STANZA_NEMICO_GENERATO["$stanza"]="true"
	fi

	STANZA_VISITATA["$stanza"]="true"

	mostra_stanza "$stanza"
}

genera_nemico() {
	local stanza="$1"
	local casuale=$((RANDOM % 100))

	if (( casuale < 40 )); then
		STANZA_NEMICO["$stanza"]="Nessuno"
	elif (( casuale < 70 )); then
		STANZA_NEMICO["$stanza"]="Goblin"
	elif (( casuale < 90 )); then
		STANZA_NEMICO["$stanza"]="Scheletro"
	else
		STANZA_NEMICO["$stanza"]="Guardiano"
	fi	
}

assegna_oggetti() {
	local stanza

	for stanza in "${!STANZA_TIPO[@]}"; do
		genera_oggetto "$stanza"
	done
}

genera_oggetto() {
	local stanza="$1"
	local casuale=$((RANDOM % 100))

	if (( casuale < 50 )); then
		STANZA_OGGETTO["$stanza"]="nessuno"
	elif (( casuale < 75 )); then
		STANZA_OGGETTO["$stanza"]="pozione"
	elif (( casuale < 90 )); then
		STANZA_OGGETTO["$stanza"]="monete"
	else
		STANZA_OGGETTO["$stanza"]="scrigno"
	fi
}

NUMERO_STANZE=6

inizializza_mappa() {

	declare -gA mappa
	declare -gA visitata

	genera_mappa

	stanza_corrente="Stanza_0"
	visitata["$stanza_corrente"]=1
}

collega_stanze() {
	local stanza_a="$1"
	local stanza_b="$2"

	mappa["$stanza_a"]+="$stanza_b "
	mappa["$stanza_b"]+="$stanza_a "
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
