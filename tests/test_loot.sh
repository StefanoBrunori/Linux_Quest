#!/bin/bash

source lib/loot.sh

> saves/inventory.txt

inizializza_pool_oggetti

echo "Pool iniziale:"
printf '%s\n' "${POOL_OGGETTI[@]}"

echo
echo "===== ESTRAZIONI ====="
echo

while [ "${#POOL_OGGETTI[@]}" -gt 0 ]
do
    trova_oggetto
    echo
done

echo "Nuovo tentativo con pool vuota:"
trova_oggetto

echo
echo "===== INVENTARIO FINALE ====="
cat saves/inventory.txt
