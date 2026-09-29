#!/bin/bash

source lib/stanze.sh

carica_stanza "data/stanze/sala_pranzo.conf"

echo "===== TEST STANZA ====="
echo

echo "Nome: $NOME_STANZA"
echo
echo "Immagine: $IMMAGINE_STANZA"
echo
echo "Descrizione: $DESCRIZIONE_STANZA"
echo
echo "Interazioni: $INTERAZIONI_STANZA"
echo
