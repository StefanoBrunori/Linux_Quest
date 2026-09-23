#!/bin/bash

# Numero di stanze della mappa di prova
NUMERO_STANZE=8

# Probabilità che appaia un mostro
PROBABILITA_MOSTRO=20

# Tasso di incremento della probabilità di incontrare il mostro
INCREMENTO_MOSTRO=10

# Probabilità che si trovi un oggetto
PROBABILITA_OGGETTO=30

inizializza_mappa() {
    # Array associativo:
    # chiave = stanza
    # valore = stanze collegate
    declare -gA mappa

    # Registra le stanze visitate
    declare -gA visitata
    
    # Dichiara l'array dei nomi delle stanze
    declare -gA nome_stanza

    # Dichiara l'array delle immagini delle stanze
    declare -gA immagine_stanza
	
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

    # Assegna nomi reali alle stanze
    nome_stanza["Stanza_0"]="Ingresso"
    nome_stanza["Stanza_1"]="Sala da Pranzo"	
    nome_stanza["Stanza_2"]="Corridoio Ovest"
    nome_stanza["Stanza_3"]="Corridoio Est"
    nome_stanza["Stanza_4"]="Cucina" 
    nome_stanza["Stanza_5"]="Camera Nobiliare"
    nome_stanza["Stanza_6"]="Camera servitù"
    nome_stanza["Stanza_7"]="Biblioteca"

    # Assegna le immagini alle stanze
    immagine_stanza["Stanza_0"]="assets/imm_ascii/ingresso.txt"
    immagine_stanza["Stanza_1"]="assets/imm_ascii/sala_pranzo.txt"
    immagine_stanza["Stanza_2"]="assets/imm_ascii/corridoio_ovest.txt"
    immagine_stanza["Stanza_3"]="assets/imm_ascii/corridoio_est.txt"
    immagine_stanza["Stanza_4"]="assets/imm_ascii/cucina.txt"
    immagine_stanza["Stanza_5"]="assets/imm_ascii/camera_nobiliare.txt"
    immagine_stanza["Stanza_6"]="assets/imm_ascii/camera_servitu.txt"
    immagine_stanza["Stanza_7"]="assets/imm_ascii/biblioteca.txt" 	 

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

mostra_stanza_corrente() {
	clear

	mostra_scenario_stanza

	mostra_uscite
}

mostra_uscite() {
    local numero_porta=1
    local destinazione

    echo
    echo "Porte disponibili:"
    echo

    for destinazione in ${mappa[$stanza_corrente]}
    do
        echo "$numero_porta) ${nome_stanza[$destinazione]}"
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

            printf "%s %-20s -> " "$simbolo" "${nome_stanza[$stanza]}"

            for destinazione in ${mappa[$stanza]}
            do
                if [ "${visitata[$destinazione]}" = "1" ]; then
                    printf "%s | " "${nome_stanza[$destinazione]}"
                else
                    printf "??? | "
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


mostra_scenario_stanza() {

	clear

	cat "${immagine_stanza[$stanza_corrente]}"

	echo
	echo "=================================="
	echo " ${nome_stanza[$stanza_corrente]}"
	echo "=================================="
}

# Funzione per esplorare la stanza
esplora_stanza() {
	local tiro_mostro
	local tiro_oggetto

	mostra_scenario_stanza

	echo
	echo "Esplori attentamente la stanza..."
	echo

	tiro_mostro=$((RANDOM % 100 + 1))
	tiro_oggetto=$((RANDOM % 100 + 1))

	# Controllo mostro
	if (( tiro_mostro <= PROBABILITA_MOSTRO )); then
		
		echo "Un mostro compare dall'oscurità!"
		echo

		echo "[TEST] Qui partirà il combattimento"

		# Reset probabilità
		PROBABILITA_MOSTRO=10

		echo
		read -r -p "Premi INVIO per continuare..."

		return

	else
		echo "Nessun mostro in vista."
		
		PROBABILITA_MOSTRO=$((PROBABILITA_MOSTRO + INCREMENTO_MOSTRO))

		if (( PROBABILITA_MOSTRO > 60 )); then
			PROBABILITA_MOSTRO=80
		fi
	fi

	echo

	# Controllo oggetto
	if (( tiro_oggetto <= PROBABILITA_OGGETTO )); then
		
		echo "Hai trovato qualcosa..."
		echo

		trova_oggetto
	else

		echo "Non trovi niente di interessante."
	fi

	echo
	read -r -p "Premi INVIO per continuare..."
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

        echo "$stanza (${nome_stanza[$stanza]})-> ${mappa[$stanza]}"
    done

    echo
    echo "@ = posizione attuale"
    echo

    read -r -p "Premi INVIO per tornare al gioco..."
}
