#!/bin/bash

introduzione() {
	
	# Musica esterna
	riproduci_musica "assets/musica/esterno.mp3"

	# Scena introduttiva
	mostra_scena \
		"assets/immagini/castello.png" \
		"assets/testi/intro.txt"
	
	# Ferma la musica esterna
	ferma_musica

	# Suono portone
	riproduci_suono "assets/suoni/portone.mp3"
	
	# Attendi che il suono finisca
	wait

	# Musica del castello
	cambia_musica "assets/musica/ingresso.mp3"

	mostra_scena \
		"assets/immagini/ingresso.png" \
		"assets/testi/ingresso.txt"
	
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
