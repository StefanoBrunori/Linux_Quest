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
