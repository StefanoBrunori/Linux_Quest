#!/bin/bash

source lib/map.sh

inizializza_mappa

echo
echo "=== MAPPA GENERATA ==="
echo

for stanza in "${!mappa[@]}"
do
    echo "$stanza -> ${mappa[$stanza]}"
done

echo
echo "Stanza iniziale: $stanza_corrente"
echo
