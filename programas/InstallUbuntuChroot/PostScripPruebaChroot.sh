#!/bin/bash
# Creado por Elias Hung
#prueba
source /home/tron/Scripts/BajoNivel.sh
source /home/tron/Scripts/AltoNivel.sh

python_ver=python3.11
dsp=$1
dl=$2
if [ -z $2 ];then dl=0; fi


{
localesterminal $dl

apt update
apt full-upgrade -y

configurarfstab $dsp $dl


echo Introduzca el nombre del usuario:
read $usuario
adduser $usuario
gpasswd -a $usuario sudo
echo "Ingrese Password"
passwd
usuario=${SUDO_USER:-${USER}}

#INSTALACIÓN DE TRON
apt install -y rsync
if [[ ! -d /home/$usuario/tron/ ]]; then
#    mv -v /home/TRON_COMPLETO/tron/ home/$usuario/tron
    cp -a -p -f /home/tron home/$usuario/tron
    if [[ ! $? == 0 ]]; then echo "Tron: Ayuda $usuario, No se ha podido copiar la Carpeta tron..."; pausa; fi
else
#   rsync -azvhl -H --delete /home/TRON_COMPLETO/tron/ /home/$usuario/tron/
    rsync -azvhl -H --delete /home/tron/ /home/$usuario/tron/
    if [[ ! $? == 0 ]]; then echo "Tron: Ayuda $usuario, Falla del teletransportador..."; pausa; fi
fi

installBash
implementar

#localesbien
if [[ ! -d /home/$usuario/repo || ! -d /home/$usuario/repo2 && -d /home/repo ]]; then
    mv -v /home/repo /home/$usuario/repo
    mv -v /home/repo2 /home/$usuario/repo2
    rsync -azvhl -H --delete /home/repo/ /home/$usuario/repo/
    rsync -azvhl -H --delete /home/repo2/ /home/$usuario/repo2/
    permisorepo
fi

permisorepo
#colamos la descarga de la llave de repositorio para microsoft code
llave EB3E94ADBE1229CF
apt update

echo
echo
cuentafinal 9 *** " Instalando Sistema Básico Y TAMBIEN Instalación de Escritorio ***"
echo
echo
echo
echo
echo ***************************************************************

installbinarios

#TODO /home/daniel/.config/micro copiar a install, configuraciones varias escritorio copiar biblioteca
#instalacionbase


#instalarXUbuntuBase
##localesbien

##instalarpost debe estar después de instalar las llaves de microsoft code
#instalarpost
#configurafirewall
#descomprimayuse
#apt full-upgrade

#instalarpython
#InstallWifiUsb
#cp-igualito /home/$usuario/tron/config/sshd_config /etc/ssh/sshd_config
#echo "file:///home/$usuario/tron" >> /home/daniel/.config/gtk-3.0/bookmarks
#streamingAudio
#LevantarStreamingAudio
#DeshabilitarAhorroEnergiaNetworkManager
#configurafirewall

#cuentafinal 3 "Actualizando Initramfs e Instalando Grub"
##update-initramfs -u
#update-grub
#lsblk
#echo "En qué dispositivo INSTALAR Grub?"
#read dispositivo
#grub-install /dev/$dispositivo

##localesbien

##CONFIGURANDO TECLADO Y UBICACIÓNES
##dpkg-reconfigure keyboard-configuration
##dpkg-reconfigure tzdat


##tasksel



} 2>&1 | tee /home/InstallUbuntu/InstalacionGENERAL.log

cp-igualito /home/InstallUbuntu/InstalacionGENERAL.log /home/$usuario/tron/install/logs/InstallUbuntu/InstalacionGENERAL.log

##desea "Deseas ver el log de Instalación?"
##si=$?
##    if [ $si == 1 ]; then
##    	nanoOvisual /home/$usuario/tron/install/logs/InstallUbuntu/InstalacionGENERAL.log
##    fi




