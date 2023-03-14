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
inicio=$PWD
cd $tron
echo
echo "Sincronizando .md"
echo
rsync --delete --delete-excluded --force  --link-dest="$PWD/" -av --prune-empty-dirs --exclude='biblioteca' --exclude='.git*' --exclude='config' --exclude='logs' --exclude='plugins' --exclude='vendor' --exclude='zboveda' --exclude='zdemas' --exclude='ZPAPELERA' --exclude='zzRespaldosDeLn' --include '*/' --include '*.md'  --exclude '*' "$tron/" "$tron/biblioteca/mkdocs/docs/Tron"
echo
echo "Sincronizando html"
echo
rsync --force  --link-dest="$PWD/" -av --prune-empty-dirs --exclude='biblioteca' --exclude='.git*' --exclude='config' --exclude='logs' --exclude='plugins' --exclude='vendor' --exclude='zboveda' --exclude='zdemas' --exclude='ZPAPELERA' --exclude='zzRespaldosDeLn' --include '*/' --include '*.html'  --exclude '*' "$tron/" "$tron/biblioteca/mkdocs/docs/Tron"
echo
cd $inicio
}

# Construye Mkdocs 
mkdocs-build () {
    inicio=$PWD
    activarentorno "Mkdocs"
    cd ~/tron/biblioteca/mkdocs
    mkdocs build
    cd $inicio
}   


legos-serve () {
    aux=$PWD
    activarentorno "Mkdocs"    
    cd /home/$usuario/tron/biblioteca/mkdocs
    python3 -m mkdocs serve > /dev/null 2>&1 &
    crom http://127.0.0.1:8000 > /dev/null 2>&1 &
    cd $aux
}

legos () {
    sinc-tron-markdown
    mkdocs-build
    legos-serve   
}
