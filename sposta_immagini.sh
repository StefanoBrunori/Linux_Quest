#!/bin/bash


copia_pc() {
	cp /mnt/c/users/stefano/desktop/personale/immagini/"$1".png assets/imm_png/"$1".png
	chafa assets/imm_png/"$1".png --size 80x22 > assets/imm_ascii/"$1".txt
}
