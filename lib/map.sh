#!/bin/bash

# Numero di stanze della mappa di prova
NUMERO_STANZE=6


inizializza_mappa() {
    # Array associativo:
    # chiave = stanza
    # valore = stanze collegate
    declare -gA mappa

    # Registra le stanze visitate
    declare -gA visitata

    genera_mappa

    stanza_corrente="Stanza_0"
    visitata["$stanza_corrente"]=1
}


collega_stanze() {
    local stanza_a="$1"
    local stanza_b="$2"

    # Evita autocollegamenti
    [ "$stanza_a" = "$stanza_b" ] && return

    # Evita collegamenti duplicati
    if [[ " ${mappa[$stanza_a]} " == *" $stanza_b "* ]]; then
	return
    fi

    # Collegamento bidirezionale
    mappa["$stanza_a"]+="$stanza_b "
    mappa["$stanza_b"]+="$stanza_a "
}


genera_mappa() {
    local i
    local nuova_stanza
    local stanza_precedente
    local indice_collegamento

    # Svuota eventuali mappe precedenti
    mappa=()
    visitata=()

    # Crea esplicitamente l'ingresso
    mappa["Stanza_0"]=""

    # Ogni nuova stanza viene collegata
    # a una stanza creata in precedenza
    for ((i = 1; i < NUMERO_STANZE; i++))
    do
        nuova_stanza="Stanza_$i"

        # Numero casuale compreso tra 0 e i-1
        indice_collegamento=$((RANDOM % i))
        stanza_precedente="Stanza_$indice_collegamento"

        collega_stanze "$nuova_stanza" "$stanza_precedente"
    done

    # Connessioni aggiuntive
    for ((i = 0; i < NUMERO_STANZE/2; i++))
    do
	local a=$((RANDOM % NUMERO_STANZE))
	local b=$((RANDOM % NUMERO_STANZE))

	[ "$a" -eq "$b" ] && continue

	collega_stanze "Stanza_$a" "Stanza_$b"
    done
}


mostra_uscite() {
    local numero_porta=1
    local destinazione

    echo
    echo "Porte disponibili:"
    echo

    for destinazione in ${mappa[$stanza_corrente]}
    do
        echo "$numero_porta) $destinazione"
        numero_porta=$((numero_porta + 1))
    done
}


cambia_stanza() {
    local destinazioni
    local indice

    # Trasforma le destinazioni della stanza corrente
    # in un array numerico
    destinazioni=(${mappa[$stanza_corrente]})

    # Il giocatore sceglie da 1 in poi,
    # mentre gli array Bash partono da 0
    indice=$((scelta - 1))

    if [ "$indice" -ge 0 ] &&
       [ "$indice" -lt "${#destinazioni[@]}" ]; then

        stanza_corrente="${destinazioni[$indice]}"

        # Registra la nuova stanza come visitata
        visitata["$stanza_corrente"]=1

    else
        echo
        echo "Porta inesistente."
        read -r -p "Premi INVIO per continuare..."
    fi
}


mostra_mappa_visitata() {
    local stanza
    local destinazione
    local simbolo

    clear

    echo "========== MAPPA VISITATA =========="
    echo

    for stanza in "${!mappa[@]}"
    do
        # Mostra soltanto le stanze già visitate
        if [ "${visitata[$stanza]}" = "1" ]; then

            if [ "$stanza" = "$stanza_corrente" ]; then
                simbolo="@"
            else
                simbolo="*"
            fi

            printf "%s %-10s -> " "$simbolo" "$stanza"

            for destinazione in ${mappa[$stanza]}
            do
                if [ "${visitata[$destinazione]}" = "1" ]; then
                    printf "%s " "$destinazione"
                else
                    printf "??? "
                fi
            done

            echo
        fi
    done

    echo
    echo "@ = posizione attuale"
    echo "* = stanza visitata"
    echo "??? = stanza collegata ma non ancora visitata"
    echo

    read -r -p "Premi INVIO per tornare al gioco..."
}


mostra_mappa_completa() {
    local stanza

    clear

    echo "========== DEBUG MAPPA =========="
    echo

    for stanza in "${!mappa[@]}"
    do
        if [ "$stanza" = "$stanza_corrente" ]; then
            printf "@ "
        else
            printf "  "
        fi

        echo "$stanza -> ${mappa[$stanza]}"
    done

    echo
    echo "@ = posizione attuale"
    echo

    read -r -p "Premi INVIO per tornare al gioco..."
}
