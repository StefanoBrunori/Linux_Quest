#!/bin/bash

ITEMS_FILE="data/items.txt"
INVENTORY_FILE="saves/inventory.txt"
EQUIPMENT_FILE="saves/equipment.txt"

mostra_equipaggiamento() {
	
	echo "===== EQUIPAGGIAMENTO ====="
	echo

	while IFS=";" read -r slot id
	do
		if [ "$id" = "0" ]; then
			echo "$slot: Slot vuoto"
		else

			nome=$(grep "^$id;" "$ITEMS_FILE" | cut -d ";" -f 2)
			
			echo "$slot: $nome"
					
		fi

	done < "$EQUIPMENT_FILE"

}

# Funzione per mostrare l'inventario
mostra_inventario() {
	
	clear
	
	cat "assets/imm_ascii/zaino.txt"

	echo
	echo "╔══════════════════════════════╗"
	echo "║          INVENTARIO          ║"
	echo "╚══════════════════════════════╝"
	echo

	if [ ! -s "$INVENTORY_FILE" ]; then
		echo "L'inventario è vuoto."
		echo
		read -r -p "Premi INVIO per continuare..."
		return
	fi
	
	while read -r quantita id
	do
		nome=$(grep "^$id;" "$ITEMS_FILE" | cut -d ";" -f 2)

		printf "%2d x %s\n" "$quantita" "$nome"
	
	done < <(sort "$INVENTORY_FILE" | uniq -c)

	echo
	echo "Premi INVIO per tornare al gioco..."
	read -r
}





















