#!/bin/bash
#Elias Hung
#elprofesorverdad@gmail.com

#Herramienta para el Trabajo con debootstrap, y chroot, para depuración permanente
# del script de "instalación de ubuntu" de forma remota, de partición a partición
# o de disco a disco.
usuario=${SUDO_USER:-${USER}}
source /home/$usuario/tron/plugins/bash/bashVariables.sh
source /home/$usuario/tron/Scripts/BajoNivel.sh
source /home/$usuario/tron/Scripts/AltoNivel.sh
source /home/$usuario/tron/programas/InstallUbuntuChroot/InstallLib.sh/installubuntulib
clear
ejecutarcomoroot


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      INTRO
#Configuración
release=jammy
arch=amd64
ruta_montaje=/mnt/instalador
#Inicicializaión de variables
menu=0
debo=0
solomontar=0
sincronizar=0
dele=0
debosch=0
nosincro=0
finalizarchroot=1
script=""
rutadsp=""
dsp=""
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  FIN INTRO

menuChroot () { 
echo "Tron: $usuario, este programa instala Ubuntu por medio de"
echo "Debotstrap y chroot  de manera remota, desde una sesión gráfica de Ubuntu,"
echo "hasta un disco o una partición. O desde una terminal a una maquina "
echo "remota. Permite depurar o actualizar la instalación."
echo
echo "Presione 0 para Solo Montar la Partición."
echo "Presione 1 para Ejecutar Chroot con PostScripChroot.sh"
echo "Presione 2 para Ejecutar Chroot sin Script."
#echo "FUERA DE SERV. Presione 3 para Introducir la ruta del Script a ejecutar después del Chroot."
#echo "FUERA DE SERV. Presione 4 para Instalar Ejecutar Chroot con Sistema BAse y Soporte Wifi."
#echo "FUERA DE SERV. Presione 5 para solo sincronizar tron en el dispositivo.dsp."
#echo 'FUERA DE SERV. Presione 6 Dele que son pasteles--> Instalación casi "...sin preguntas."'
#echo "FUERA DE SERV. Presione 7 para desmontar todas las particiones."
#echo "FUERA DE SERV. Presione 8 para Solo debootstrap y chroot."
echo "Presione 9 para Ejecutar PartiClon."

read frase
case $frase in
    0)

        Solo_Montar
    ;;
    1)

    ;;
    2)
        SoloMontarChroot
    ;;
    3)

    ;;
    4)

    ;;
    5)
        

    ;;
    6)
    
    ;;
    7)

    ;;
    8)

    ;;
    9)
        
    ;;
esac

}

menuChroot


#  OTRAS FUNCIONES 
Funciones () {
pidedisp "DONDE SE MONTARÁ EL CHROOT"
siErutaDeMontaje_FormatyCreaRutaDeMontaje_SiNo_CreaRutaDeMontaje
siNoErutaDeMontaje_CreaRutaDeMontaje
montapar $dsp $ruta_montaje
estableceretiqueta
HacerDebootstrap
montarPartChroot $ruta_montaje
# Log en /home/$usuario/tron/install/logs/InstallUbuntu/queDebostrap.log
hacerdeboststrap
# DEBOSTRAP HECHO A PARTIR DE AQUÍ YA HAY UN SISTEMA MÍNIMO.
preguntadera
desmontartodo $ruta_montaje
Tron-Init
cuentafinal 3 "Tron Init Copiado"
copiarAptRepos $ruta_montaje
#---------->HACE CHROOT
cuentafinal 2 "Ejecutando chroot en la partición y script si lo hay..."
MontaChroot
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@------------------------------------>REGRESANDO DEL CHROOT
preguntaspostchroot
}



