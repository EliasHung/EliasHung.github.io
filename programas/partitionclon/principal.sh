#!/bin/bash
#Elías Hung
#elprofesorverdad@gmail.com
#Respalda y recupera particiones de dispositivos


if [[ -z $1 ]]; then
    echo "Debe especificar un usuario en el primer parámetro"
    echo "Ingrese el nombre del usuario"
    read usuario
else
    usuario=$1
fi
source /home/$usuario/tron/Scripts/BajoNivel.sh
source /home/$usuario/tron/Scripts/AltoNivel.sh
$programas/InstallUbuntuChroot/InstallLib.sh/installubuntulib
particiondestino="sdc9"
respaldopordefectoiso="/media/sdc9/UbuntuMinimo22.04HWE5.15.0-52-genericx86_64.iso"

fuente=""
puntodemontaje=""
puntodemontajedestino=""
dsp=""
file=""
rutadsp=""

ejecutarcomoroot (){
    if (( $EUID != 0 )); then
        echo TRON:
        echo "Mi usuario $usuario por favor ejecute como root"
        echo "y así, venceremos a control maestro"
        sudo su
    else
        echo
        echo "YA TENGO EL PODER...!"
        echo
    fi
}

pidedisp () {
    echo  "Introduzca la partición $1: Ej: sda, sdd2 "
    read dsp
    rutadsp="/dev/$dsp"
}


pidenomrespaldo () {
    echo
    listarrespaldos
    echo
    echo "Ingrese el Nombre del respaldo (sin la extensión)"

    read nombre
}

ensamblanombreext () {
    ext=$1
    file="$nombre.$ext"
}


montardsp () {
mount $rutadsp
}

montarsource () {
    fuente="$rutadsp"
    mkdir /media/$dsp
    puntodemontaje="/media/$dsp"
    umount -lf $puntodemontaje
    mount -o ro $fuente $puntodemontaje
    mount -o remount,ro $ $puntodemontaje
}

montardestino () {
    destino="/dev/$particiondestino"
    
    mkdir /media/$particiondestino
    puntodemontajedestino="/media/$particiondestino"
    umount -lf $puntodemontajedestino
    mount $destino $puntodemontajedestino
    #mount -o ro $destino $puntodemontajedestino
    #mount -o remount,ro $destino $puntodemontajedestino
}



resp () {
    echo
    echo "respaldando de: $fuente a $puntodemontajedestino"
    echo
    dd if="$fuente" |pv|dd of="$puntodemontajedestino/$file"
    exit
}


ComprimirDDdesdeIso () {
    pidedisp "a Comprimir"
    pidenomrespaldo
    file="$nombre.iso"
    fuente="$rutadsp"
    montardestino
    echo
    echo "respaldando de: $fuente a $puntodemontajedestino"
    echo
    numdebloquesde1k=$(var=$(df "$rutadsp" |grep /dev); echo $var | cut -d " " -f 2)
    di=4096
    let bits=$numdebloquesde1k*$di
    echo
    desea "Bajar la Prioridad del Proceso"
    si=$?
        if [[ -z $si ]]; then echo "Por favor elija una prioridad"; exit; fi 
        if [ $si == 1 ]; then
            echo "Ingrese el nivel de prioridad: desde 1 para prioridad mas alta; hasta 19 para prioridad mas baja."
            read numero
            echo "Tron: CIBER-TURBO ACTIVADO...!"
            nice -+$numero dd if="$fuente" bs=4096|pv -s "$bits"|nice -+$numero dd bs=4096 of="$puntodemontajedestino/$file"
        else
            echo "Tron: CIBER-TURBO ACTIVADO...!"
            dd if="$fuente" bs=4096|pv -s "$bits"|dd bs=4096 of="$puntodemontajedestino/$file"
        fi
    exit
}



descomprimirDDdesdeIso () {
    pidedisp "destino donde se descomprimirá el iso "
    pidenomrespaldo
    file="$nombre.iso"
    fuente="$rutadsp"
    borraParticionYrutaDeMontaje $fuente
    montardestino
    echo
    echo "recuperando de: $puntodemontajedestino a $fuente"
    echo
    numdebloquesde1k=$(var=$(df "$rutadsp" |grep /dev); echo $var | cut -d " " -f 2)
    di=4096
    let bits=$numdebloquesde1k*$di
    echo "Tron: CIBER-TURBO ACTIVADO...!"
    dd if="$puntodemontajedestino/$file" bs=4096|pv -s "$bits"|dd bs=4096 of="$fuente"
    exit
}


clonarconzstd () {
    echo "Ingrese el nivel de compresión del 1 al 19"
    read nivel
    zstd -$nivel -v --threads=0 <$rutadsp >"$puntodemontajedestino/$file"
    # zstdcat -v /media/mint/Data/_Fsarchiver/MintV1.zst >/dev/sda2
}


descomprimirconzstdcat () {
pidedisp "dispositivo destino donde se descomprimirá el zstd"

pidenomrespaldo
ensamblanombreext "zst"
montardestino
formatearparticion $rutadsp
zstdcat -v "$puntodemontajedestino/$file" >"$rutadsp"
configurardescomprimido $dsp
}

configurardescomprimido () {
    dispo=$1
    umount -lf /dev/$dispo
    echo "Verificando partición"
    e2fsck -f -y -C 0 /dev/$dispo
    echo "Redimensionando el sistema de archivos"
    resize2fs -p /dev/$dispo
    echo "UUID de partición antiguo:"
    blkid | grep $dispo
    cuentafinal 4 "Cambiando UUID"
    tune2fs -U random /dev/$dispo
    echo "UUID de partición nuevo:"
    blkid | grep $dispo
    # Cambiar fstab  y luego con chrrot ver si hace el arreglo del initrtl etc...
    #y update grub
    configurarfstab $dispo
    grubi
    exit
}

listarrespaldos () {
echo Montando Partición de Respaldos
    destino="/dev/$particiondestino"
    mkdir /media/$particiondestino
    puntodemontajedestino="/media/$particiondestino"
    umount -lf $puntodemontajedestino
    mount $destino $puntodemontajedestino

cd $puntodemontajedestino
echo
echo Listando Respaldos:
echo
for respaldo in *
do
    echo $respaldo
done
}

formatearparticion () {
    ruta_montaje=$1

    desea "Formatear la Partición llamada: $ruta_montaje?"
    si=$?
    if [ $si == 1 ]; then
       umount -lf $ruta_montaje
       mkfs.ext4 -F -v $ruta_montaje

    fi

}

#*********************************************************************************************
#*********************************************************************************************
#*********************************************************************************************
MenuOp ()
{
    clear
    echo "PartiClon realiza una imagen iso comprimida de un dispositivo"
    echo "puede descomprimir y restaurar dichas imágenes posteriormente"
    echo "hasta un disco o una partición. O desde una terminal a una maquina remota."
    echo
    echo "Presione 0 para Clonar el dispositivo con dd a .iso."
    echo "Presione 1 para Clonar  el dispositivo con zstd a .zst"
    echo "Presione 2 para Descomprimir con dd desde .iso a dispositivo"
    echo "Presione 3 para Descomprimir con zstd desde .zst a dispositivo"
    echo "Presione 4 para Configurar Sistema en dispositivo recién Descomprimido"
    echo "Presione 5 para Ejecutar MontarChroot "
    echo 'Presione 6 para'
    echo "Presione 7 para "
    echo "Presione 8 para "
    read frase
    case $frase in
    0)
        ComprimirDDdesdeIso
        exit 0
    ;;
    1)
        pidedisp
        pidenomrespaldo
        montardestino
        file="$nombre.zst"
        clonarconzstd
        exit 0
    ;;
    2)
        descomprimirDDdesdeIso
        configurardescomprimido $dsp
        exit 0
    ;;
    3)
         descomprimirconzstdcat
    ;;
    4)
        pidedisp
        #no se debe montar del dispositivo
        configurardescomprimido $dsp
        exit 0
    ;;
    5)
        /bin/bash "/home/daniel/tron/InstallUbuntuChroot/MontarChroot.sh"
    ;;
    6)
        
    ;;
    7)
        
    ;;
    8)
        
    ;;
    esac
}

MenuOp




