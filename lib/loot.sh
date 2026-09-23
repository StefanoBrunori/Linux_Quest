#!/bin/bash

ITEMS_FILE="data/items.txt"
INVENTORY_FILE="saves/inventory.txt"
LOOT_AREA_FILE="data/loot_area_1.txt"
OGGETTO_ESTRATTO=""

declare -ga POOL_OGGETTI


# Crea la pool degli oggetti per la macroarea
inizializza_pool_oggetti() {
	local id

	POOL_OGGETTI=()

	while read -r id
	do
		# Ignora righe vuote
		[ -z "$id" ] && continue

		# Ignora commenti
		[[ "$id" == \#* ]] && continue

		POOL_OGGETTI+=("$id")

	done < "$LOOT_AREA_FILE" 

}

# Tira fuori un oggetto casuale dalla pool
estrai_oggetto_casuale() {
	local quantita
	local indice

	quantita=${#POOL_OGGETTI[@]}

	if [ "$quantita" -eq 0 ]; then
		return 1
	fi

	indice=$((RANDOM % quantita))

	OGGETTO_ESTRATTO="${POOL_OGGETTI[$indice]}"

	# Elimina l'oggetto estratto dalla pool
	unset "POOL_OGGETTI[$indice]"

	# Ricompatta gli indici dell'array
	POOL_OGGETTI=("${POOL_OGGETTI[@]}")
}

# Ottiene il nome dell'oggetto estratto
ottieni_nome_oggetto() {
	local id="$1"

	grep "^$id;" "$ITEMS_FILE" | cut -d ";" -f 2
}

# Aggiunge l oggetto trovato all inventario
aggiungi_oggetto_inventario() {
	local id="$1"

	echo "$id" >> "$INVENTORY_FILE"
}

# Funzione completa per trovare un oggetto
trova_oggetto() {
	local id
	local nome

	if [ "${#POOL_OGGETTI[@]}" -eq 0 ]; then
		echo "Hai esplorato a fondo questa parte del castello."
		echo "Non ci sono più oggetti da trovare."
		return 1
	fi
	
	estrai_oggetto_casuale

	id="$OGGETTO_ESTRATTO"

	if [ -z "$id" ]; then
		echo "Errore durante l'estrazione dell'oggetto." 
		return 1
	fi

	nome=$(ottieni_nome_oggetto "$id")

	aggiungi_oggetto_inventario "$id"
	
	echo "Hai trovato: $nome"
	echo "L'oggetto è stato aggiunto all'inventario."
	echo
	echo "Oggetti ancora disponibili nell'area: ${#POOL_OGGETTI[@]}"
}
























