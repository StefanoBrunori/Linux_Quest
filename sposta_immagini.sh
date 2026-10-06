#!/bin/bash


copia_pc() {
	cp /mnt/c/users/stefano/desktop/personale/immagini/"$1".png assets/imm_png/"$1".png
	chafa assets/imm_png/"$1".png --size 80x22 > assets/imm_ascii/"$1".txt
}

copia_hc() {
	cp /mnt/c/users/keray/desktop/immagini_linux_quest/"$1".png assets/imm_png/"$1".png
	chafa assets/imm_png/"$1".png --symbols ascii --size 80x22 > assets/imm_ascii/"$1".txt
}

schemi_pc_linux() {
	cp /mnt/c/users/stefano/desktop/personale/schemi/"$1".png immagini
}

schemi_linux_pc() {
	cp immagini/"$1".png /mnt/c/users/keray/desktop/immagini_linux_quest
}
