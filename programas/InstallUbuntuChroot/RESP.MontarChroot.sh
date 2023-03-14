#!/bin/bash
#Elias Hung
#elprofesorverdad@gmail.com

#Herramienta para el Trabajo con debootstrap, y chroot, para depuración permanente
# del script de "instalación de ubuntu" de forma remota, de partición a partición
# o de disco a disco.
clear
ruta_montaje=/mnt/instalador
usuario=${SUDO_USER:-${USER}}
source /home/$usuario/tron/plugins/bash/bashVariables.sh
source /home/$usuario/tron/Scripts/BajoNivel.sh
source /home/$usuario/tron/Scripts/AltoNivel.sh
ejecutarcomoroot
release=jammy
arch=amd64
debo=0
solomontar=0
sincronizar=0
dele=0
debosch=0
nosincro=0
finalizarchroot=1
#localesterminal $dele
sources () {
#cp -a -p -f -v /home/$usuario/repo $ruta_montaje/home/
#dosopciones "Instalar las sources.list de este sistema" "Instalar sources.list de Ubuntu Jammy"
#vari=$?
#if [[ $vari == 1 ]]; then
#cp-igualito "/etc/apt/sources.list" "$ruta_montaje/etc/apt/"
#else
cp-igualito "/home/$usuario/tron/config/sources.list/ubuntu-jammy-original/sources.list" "$ruta_montaje/etc/apt/"
#fi
}
Tron-Init () {
mkdir $ruta_montaje/home/tron
#mkdir $ruta_montaje/home/tron/plugins
chmod -v 775 $ruta_montaje/home/tron
#chmod -v 775 $ruta_montaje/home/tron/plugins
#cp -a -p -f -v /home/$usuario/tron/plugins/bash $ruta_montaje/home/tron/plugins/


#rsync -azvhl -H --delete --exclude "/biblioteca" --exclude "/plugins" --exclude "sesiones" --exclude "zdemas" --exclude "ZPAPELERA" --exclude "zzRespaldosDeLn" /home/$usuario/tron/ $ruta_montaje/home/tron/

rsync -azvhl -H --exclude "navegadores" --exclude "Drivers" "/home/$usuario/tron/" "$ruta_montaje/home/tron/"

}







#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  FIN FUNCIONES Y VARIABLES



echo
echo
echo  'Introduzca la partición "DONDE SE MONTARÁ EL CHROOT": Ej: sda, sdd2 "'
read dsp
echo
script=""
menu=0
MenuOp ()
{
    echo "Tron: $usuario, este programa instala Ubuntu por medio de"
    echo "Debotstrap y chroot  de manera remota, desde una sesión gráfica de Ubuntu,"
    echo "hasta un disco o una partición. O desde una terminal a una maquina "
    echo "remota. Permite depurar o actualizar la instalación."
    echo
    echo "Presione 0 para Solo Montar la Partición."
    echo "Presione 1 para Ejecutar Chroot con PostScripPruebaChroot.sh"
    echo "Presione 2 para Ejecutar Chroot sin Script."
    echo "Presione 3 para Introducir la ruta del Script a ejecutar después del Chroot."
    echo "Presione 4 para Instalar Ejecutar Chroot con Sistema BAse y Soporte Wifi"
    echo "Presione 5 para solo sincronizar tron en el dispositivo.dsp"
    echo 'Presione 6 Dele que son pasteles--> Instalación casi "...sin preguntas."'
    echo "Presione 7 para desmontar todas las particiones"
    echo "Presione 8 para Solo debootstrap y chroot"

    read frase
    case $frase in
    0)
        solomontar=1
        script=""
		menu=1
    ;;
    1)
        script="/home/tron/InstallUbuntuChroot/PostScripPruebaChroot.sh"
        debosch=1
		menu=1
    ;;
    2)
        nosincro=1
        script=""
        menu=1
    ;;
    3)
        echo "Introduzca la ruta del script"
        read ruta
        script="$ruta"
        menu=1
    ;;
    4)
        script="/home/tron/InstallUbuntuChroot/SoloSisBaseySoporteWifi.sh"
        menu=1
        finalizarchroot=0
        debosch=1
    ;;
    5)
        
        menu=1
        sincronizar=1
    ;;
    6)
        
        menu=1
        dele=1
        script="/home/tron/InstallUbuntuChroot/PostScripPruebaChroot.sh"
    ;;
    7)
        desmontartodo $ruta_montaje
        umount -lf
        exit 0
    ;;
    8)
        nosincro=1
        debosch=1
        menu=1
    ;;
    esac
}

MenuOp

if [ $solomontar == 1 ]
then
    if [[ ! -d $ruta_montaje ]]; then
        mkdir $ruta_montaje
    fi
    montapar $dsp $ruta_montaje
    exit
fi


if [ $menu == 1 ]
    then
    if [ $sincronizar == 0 ]
    then
        echo
        echo "Si deseas Borrar la partición e instalar debooststrap"
        echo "presiona 1 "
        echo "cualquier tecla para solo hacer chroot"
        #para que no de el error se esperaba un operador unario
        if [[ $dele == 0 ]]; then
            read op; if [ -z $op ];then op=0; fi
        else
            op=1
        fi
        if [ $op == 1 ]; then
            if [ -d $ruta_montaje ]
            then
                echo “La capeta $ruta_montaje ya existe.”
                echo "se borrará carpeta antigua..."
                #mount /dev/$dsp $ruta_montaje
                desmontarParcial $ruta_montaje
                #rm -r -d -v $ruta_montaje/*
                umount -lf $ruta_montaje
                umount -lf $dsp
                mkfs.ext4 -F -v /dev/$dsp
                debo=1
                if [[ $dele == 0 ]]; then
                    preguntasalir "Borró la partición" "Si no lo hizo finalice el script y ejecútelo en una nueva pestaña de la terminal."
                fi
                #umount -lf $ruta_montaje
                rm -d -v $ruta_montaje
                mkdir $ruta_montaje
            else
                mkdir $ruta_montaje
                if [ $? == 0 ]
                then
                    echo “$dir se ha creado con éxito”
                else
                    echo “TRON: Algo ha fallado al crear $ruta_montaje”
                    echo “TRON: Permisos?”
                    exit
                fi
            fi
        fi
    fi

    if [[ ! -d $ruta_montaje ]]; then
        mkdir $ruta_montaje
    fi
    montapar $dsp $ruta_montaje

    if [ $debosch == 1 ]; then 


        debootstrap --arch=${arch} ${release} $ruta_montaje
        montarPartChroot $ruta_montaje
        desea "Instalar sources.list?"
        si=$?
            if [ $si == 1 ]; then
                sources
            fi
            
        desea "Instalar Tron-Init?"
        si=$?
            if [ $si == 1 ]; then
                Tron-Init
                cuentafinal 3 "Tron Init Copiado"
            fi
            
        desea "Copiar repos de Apt"
        si=$?
            if [ $si == 1 ]; then
             copiarAptRepos $ruta_montaje
            fi





    fi
    
    
        if [[ -z $script ]]; then
            montarPartChroot $ruta_montaje
            chroot $ruta_montaje 
        else 
            
            chroot $ruta_montaje "$script" "$dsp" "$dele"
        fi
        exit
    fi


    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #------------------------------------------> HACIENDO DEBOSTRAP A PARTIR DE AQUÍ YA HAY UN SISTEMA MÍNIMO
    if [[ $op == 1 ]]; then
        cuentafinal 6 "Instalando Sistema Mínimo Linux en la partición con debootstrap..."
        {
            debootstrap --arch=${arch} ${release} $ruta_montaje
        } 2>&1 | tee /home/$usuario/tron/install/logs/InstallUbuntu/queDebostrap.log
    fi
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    montarPartChroot $ruta_montaje

    if [ $sincronizar == 1 ]; then
        rsync -azvhl -H --delete /home/$usuario/tron/  $ruta_montaje/home/$usuario/tron/
        desmontartodo $ruta_montaje
    exit
    fi


    #VIENEN LOS DESEOS...
    if [[ $dele == 1 ]]; then
        sources
        Tron-Init
        cuentafinal 3 "Tron Init Copiado"
#        copiadetron $ruta_montaje
        copiarAptRepos $ruta_montaje
    fi
    if [[ $dele == 0 ]]; then
        desea "Instalar sources.list?"
        si=$?
            if [ $si == 1 ]; then
                sources
            fi
        desea "Instalar Tron-Init?"
        si=$?
            if [ $si == 1 ]; then
                Tron-Init
                cuentafinal 3 "Tron Init Copiado"
            fi
        desea "Copiar Tron"
        si=$?
            if [ $si == 1 ]; then
                copiadetron $ruta_montaje 
            fi

        desea "Copiar repos de Apt"
        si=$?
            if [ $si == 1 ]; then
             copiarAptRepos $ruta_montaje
            fi
    fi
    
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-------------------------------------->HACE CHROOT
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    cuentafinal 2 "Ejecutando chroot en la partición y script si lo hay..."
    
    if [[ -z $script ]]; then
        chroot $ruta_montaje 
    else 
        chroot $ruta_montaje "$script" "$dsp" "$dele"
    fi
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@------------------------------------>REGRESANDO DEL CHROOT
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    #CHEQUEA SI CHROOT TUVO ERRORES
    if [ $? == 0 ]; then
        cuentafinal 3 "---->REGRESANDO DEL CHROOT cript Chroot Finalizado Con exito"
    else 
        cuentafinal 9 "---->REGRESANDO DEL CHROOT Se produjo un error al hacer chroot o Con el Script"
    fi

    if [[ finalizarchroot == 1 ]] then

        if [[ $nosincro == 0 ]]; then
            cuentafinal 2 "---->REGRESANDO DEL CHROOT Ultima actualizacion de tron"
            rsync -azvhl -H --delete /home/$usuario/tron/  $ruta_montaje/home/$usuario/tron/
        fi
        
        desea "---->REGRESANDO DEL CHROOT Etiquetar el dispositivo"
            si=$?
        if [ $si == 1 ]; then
            pidenombrehost $ruta_montaje
            echo Etiqueta de la Nueva partición $dsp?
            read nombre
            e2label /dev/$dsp $nombre
        fi
        



        
            desea "---->REGRESANDO DEL CHROOT Actualizar e instalar grub"
            si=$?
        if [ $si == 1 ]; then
            update-grub
            echo "---->REGRESANDO DEL CHROOT En que dispositivo instalar grub"
            read donde
            grub-install /dev/$donde
        fi

        desea "---->REGRESANDO DEL CHROOT Desmontar todo"
            si=$?
        if [ $si == 1 ]; then
            desmontartodo $ruta_montaje
        fi
    fi
    
else
    echo Tron: $usuario, Por favor elija una opción
    echo Tron: $usuario, extrano a Ram...
    exit
fi

#NOTAS de COMENTARIO

#cp /usr/share/zoneinfo/America/Caracas $ruta_montaje/home
#cp /etc/default/locale $ruta_montaje/home
#cp /etc/timezone $ruta_montaje/home


