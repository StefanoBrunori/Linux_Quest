#!/bin/bash

source lib/music.sh
source lib/ui.sh
source lib/story.sh
source lib/map.sh

echo "=== TEST INTRODUZIONE ==="
echo

inizializza_mappa
introduzione

echo
echo "=== TEST TERMINATO ==="
echo
echo "Stanza corrente: $stanza_corrente"
echo

ferma_musica
