#!/bin/bash

riproduci_musica() {
	local file="$1"

	mpg123 -q --loop -1 "$file" &
	MUSICA_PID=$!
}

ferma_musica() {
	
	if [ -n "$MUSICA_PID" ]; then
		kill "$MUSICA_PID" 2>/dev/null
		wait "$MUSICA_PID" 2>/dev/null

		MUSICA_PID=""
	fi
}

riproduci_suono() {
	local file="$1"

	mpg123 -q "$file"
}
