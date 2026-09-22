#!/bin/bash

introduzione() {
	
	# Musica esterna
	riproduci_musica "assets/musica/esterno.mp3"

	# Scena introduttiva
	mostra_scena \
		"assets/imm_ascii/castello.txt" \
		"assets/testi_stanze/intro.txt"
	
	# Ferma la musica esterna
	ferma_musica

	# Suono portone
	riproduci_suono "assets/suoni/portone.mp3"
	
	# Attendi che il suono finisca
	wait

	# Musica del castello
	riproduci_musica "assets/musica/ingresso.mp3"

	clear

	mostra_scena \
		"assets/imm_ascii/ingresso.txt" \
		"assets/testi_stanze/ingresso.txt"
	
	stanza_corrente="Stanza_0"
	visitata["$stanza_corrente"]=1
}

mostra_scena() {

	local immagine="$1"
	local testo="$2"

	clear

	cat "$immagine"

	echo
	cat "$testo"

	echo
	read -p "Premi INVIO per continuare..."

}
