#!/bin/bash

source lib/combat.sh

personaggio_nome="Stefano"
personaggio_vita=20
personaggio_attacco=5
personaggio_danno=4

combatti "Goblin" 15 8 3

esito=$?

echo
echo "Esito combattimento: $esito"
echo "Vita rimanente: $personaggio_vita"
