#!/bin/bash
#Elias Hung
#elprofesorverdad@gmail.com

#Herramienta para el Trabajo con debootstrap, y chroot, para depuración permanente
# del script de "instalación de ubuntu" de forma remota, de partición a partición
# o de disco a disco.
usuario=${SUDO_USER:-${USER}}
source /home/$usuario/tron/plugins/bash/bashVariables.sh
source /home/$usuario/tron/Scripts/BajoNivel.sh


clear
ejecutarcomoroot


Admon () { 
echo "Tron: $usuario, Programas Adminstrativos"
echo "Programas para la Administración General del Sistema"
echo
echo "Presione 0 para MontarChroot"
echo "Presione 1 para Ejecutar Particlon"
#echo "FUERA DE SERV. Presione 2"
#echo "FUERA DE SERV. Presione 3"
#echo "FUERA DE SERV. Presione 4"
#echo "FUERA DE SERV. Presione 5"
#echo 'FUERA DE SERV. Presione 6'
#echo "FUERA DE SERV. Presione 7"
#echo "FUERA DE SERV. Presione 8"
#echo "FUERA DE SERV. Presione 9"
echo "Presione Crtl+c Para Salir"

read frase
case $frase in
    0)

        MontarChroot
    ;;
    1)
        PartiClon $usuario
    ;;
    2)
        
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

Admon



