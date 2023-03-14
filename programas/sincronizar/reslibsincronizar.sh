#!/bin/bash
# @file sincronizar.sh
# @brief Una libreria que sincroniza todo en tron
# @description
# @see [sinc-tron-md](sinc-tron-md)
# 


# @description sinc-tron-md.
# Sincroniza todas las carpetas que contengan un archivo .md
# desde tron hasta la biblioteca en mkdocs.
# @noargs

# Sincroniza todos los .md desde tron hasta mkdocs conservando el árbol de carpetas.
# Los enlaces son enlaces duros
sinc-tron-markdown () {
rsync --delete  --link-dest="$PWD/$tron/" -av --prune-empty-dirs --exclude='biblioteca' --exclude='.git*' --exclude='config' --exclude='logs' --exclude='plugins' --exclude='vendor' --exclude='zboveda' --exclude='zdemas' --exclude='ZPAPELERA' --exclude='zzRespaldosDeLn' --include '*/' --include '*.md' --exclude '*' "$tron/" "$tron/biblioteca/mkdocs/docs/Tron"
}

# Construye Mkdocs 
mkdocs-build () {
    inicio=$PWD
    activarentorno "Mkdocs"
    cd ~/tron/biblioteca/mkdocs
    mkdocs build
    cd $inicio
}   

sincroTronDocu () {
    sinc-tron-markdown
    mkdocs-build
}

