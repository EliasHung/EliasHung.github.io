#!/bin/bash
# Creado por Elias Hung
#prueba
source /home/tron/Scripts/BajoNivel.sh
source /home/tron/Scripts/AltoNivel.sh

echo el usuario en source es $usuario
pausa
read nano
python_ver=python3.11
dsp=$1
dl=$2
if [ -z $2 ];then dl=0; fi


{
localesterminal $dl
apt update
apt upgrade
#mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

configurarfstab $dsp $dl



echo Introduzca el nombre del usuario:
read $usuario
echo el usuario al leer de la entrada es es $usuario
pausa
read nano

adduser $usuario
gpasswd -a $usuario sudo
echo "Ingrese Password"
passwd
usuario=${SUDO_USER:-${USER}}
echo el usuario en la variable automática es $usuario
pausa
read

#INSTALACIÓN DE TRON
apt install -y rsync
if [[ ! -d /home/$usuario/tron/ ]]; then
#    mv -v /home/TRON_COMPLETO/tron/ home/$usuario/tron
    mv -v /home/tron home/$usuario/tron
    if [[ ! $? == 0 ]]; then echo "Tron: Ayuda $usuario, No se ha podido mover la Carpeta tron..."; pausa; fi
else
#   rsync -azvhl -H --delete /home/TRON_COMPLETO/tron/ /home/$usuario/tron/
    rsync -azvhl -H --delete /home/tron/ /home/$usuario/tron/
    if [[ ! $? == 0 ]]; then echo "Tron: Ayuda $usuario, Falla del teletransportador..."; pausa; fi
fi

installBash
implementar


if [[ ! -d /home/$usuario/repo || ! -d /home/$usuario/repo2 && -d /home/repo ]]; then
    mv -v /home/repo /home/$usuario/repo
    mv -v /home/repo2 /home/$usuario/repo2
    rsync -azvhl -H --delete /home/repo/ /home/$usuario/repo/
    rsync -azvhl -H --delete /home/repo2/ /home/$usuario/repo2/
    permisorepo
fi


echo
echo
cuentafinal 4 " Instalando Sistema Básico con nucleo 6 Y TAMBIEN Drivers USB "
echo
echo
echo
echo
echo ***************************************************************


installkernel6 $usuario
pausa "instalo kernel????"
descomprimayuse
apt install -y network-manager 
cp-igualito /home/$usuario/tron/config/sshd_config /etc/ssh/sshd_config
streamingAudio
LevantarStreamingAudio
DeshabilitarAhorroEnergiaNetworkManager
InstallWifiUsb
ufw allow OpenSSH


cuentafinal 3 "Actualizando Initramfs e Instalando Grub"
#update-initramfs -u
update-grub

#echo "En qué dispositivo INSTALAR Grub?"
#read dispositivo
#grub-install /dev/$dispositivo
echo "Abriendo Terminal interna en Chroot"
/bin/bash




} 2>&1 | tee /home/tron/install/logs/InstallUbuntu/InstalacionGENERAL.log

cp-igualito /home/tron/install/logs/InstallUbuntu/InstalacionGENERAL.log /home/$usuario/tron/install/logs/InstallUbuntu/InstalacionGENERAL.log

#desea "Deseas ver el log de Instalación?"
#si=$?
#    if [ $si == 1 ]; then
#    	nanoOvisual /home/$usuario/tron/install/logs/InstallUbuntu/InstalacionGENERAL.log
#    fi




