#!/bin/bash
# Creado por Elias Hung

#FUNCIONES
preguntasalir () {
echo "TRON:"
echo $1...?
echo "Nota: $2"
echo "Presiona 1 Para salir"
echo  "Presiona Cualquier otra tecla para continuar"
read frase
case $frase in
	1)
		salir=1
	;;
	2)
		salir=0
		
    ;;
esac

if [ $salir -eq 1 ]
then
    exit
fi
}

cuentafinal () {
setterm -term linux -back red -fore white
echo "---------------------------------------- $2 --------------------------------------" 
setterm -term linux -default
echo
echo
sleep 1 # seconds
cont=0
DURATION=$(( $1  )) # convert minutes to seconds
START=$(date +%s)
x=-1
print0=1
while [ $x == -1 ]; do
	NOW=$(date +%s)				# get time now in seconds
	DIF=$(( $NOW-$START ))			# compute diff in seconds
	ELAPSE=$(( $DURATION-$DIF ))		# compute elapsed time in seconds
	MINS=$(( $ELAPSE/60 ))			# convert to minutes... (dumps remainder from division)
	SECS=$(( $ELAPSE - ($MINS*60) )) 	# ... and seconds
	if [ $MINS == 0 ] && [ $SECS == 0 ]	# if mins = 0 and secs = 0 (i.e. if time expired)
	then 					# blink screen
		for i in `seq 1 180`;    		# for i = 1:180 (i.e. 180 seconds)
		do
			if [ $print0==1 ]
            then
                echo 
            fi
			sleep 0.5
			sleep 0.5	
            let cont=cont+1
            print0=0
            if [ $cont == 1 ]
            then
                setterm -term linux -back red -fore white
                echo "******************************************* $2 ************************************************" 
                x=0
                setterm -term linux -default    
                echo
                break
            fi
		done  					# end for loop 
		break					# end script

	else 					# else, time is not expired
		echo "00:00:0$SECS"			# display time
		sleep 1  				# sleep 1 second
	fi					# end if
done	# end while loop	
echo
}
#*************************************************FIN FUNCIONES********************************************


# Este programa instala las llaves de repositorios y repositorios faltantes
# El Kernel y los programas principales programas para el funcionamiento del sistema operativo
# Acá se instala el entorno de escritorio xubuntu, kubuntu, lubuntu, ubuntu server, etc
# se configuraa el idioma la fecha y hora

#Notas: Esta diseñado para ser instalado desde la computadora o partición fuente,
# es decir la computadora o partición que está haciendo chroot, tambien se puede
# ejecutar despues de inicializar la computadora o partición destino pero hay que
# modificar la fuente de las carpetas de idioma más abajo.

#Instala las dependencias de tron, carga variables y configuración de bashrc enlaza las herramientas y otorga los
#permisos necesarios para el funcionamiento 

#TRON: 
# Automatiza y la gestióna los comandos complicados haciéndolos más fáciles de usar, gestiona la edición y ejecución de
# Funciones Python, Bash, Java, y todo tipoo de   scripts y variables de trabajo. Permite trabajar más rápidamente por Cónsola
# Ayuda y protege y defiende al usuario.

#cp /usr/share/zoneinfo/America/Caracas /etc/localtime
#echo 'LANG=es_ES.UTF-8' > /etc/default/locale
#echo 'America/Caracas' > /etc/timezone
# Para Vlc el repositorio se aplicó 
# echo 'Dir::Bin::Methods::ftp "ftp";' | sudo tee -a /etc/apt/apt.conf.d/99local-ftp


#VARIABLES
python_ver=python3.11
con=2
dsp=$1

#rm /etc/localtime
#cat /home/Caracas > /etc/localtime
#cp -a -p -f -v /home/locale /etc/default/locale
#cp -a -p -f -v /home/timezone /etc/timezone
#locale-gen es_ES.UTF-8
#dpkg-reconfigure -f non-interactive tzdata

#apt-get update
##apt-get install -y language-pack-es-base
#apt-get install -y language-pack-en-base
#apt-get upgrade

dpkg-reconfigure locales
apt-get update
#echo "/dev/$dsp    /    ext4    errors=remount-ro    0    1">> $ruta_montaje/etc/fstab
echo "UUID=`blkid -s UUID -o value /dev/$dsp` / ext4 defaults 1 1" >> $ruta_montaje/etc/fstab
cuentafinal 6 "fstab actualizado"


let con++
{
#figlet -c "Parte $con"
echo
echo
cuentafinal 5 "********************************** INSTALANDO KERNEL "
echo
echo *******************************************************************
apt-get install -y --no-install-recommends linux-generic linux-image-5.15.0-52-generic linux-headers-5.15.0-52-generic linux-modules-5.15.0-52-generic linux-modules-extra-5.15.0-52-generic
cuentafinal 4 "************************** INSTALANDO DRIVERS VARIOS Y NVIDIA"
echo
echo
echo
echo
echo *********************************************************
apt-get install -y libnvidia-compute-520 libvdpau1 nvidia-prime nvidia-utils-520 ubuntu-drivers-common vdpau-driver-all


echo ************************************Fin de instalacion de Nvidia
} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-InstalarUbuntu-Kernel-Nvidia.log
preguntasalir "Ver el log de Instalacion de Kernel-Nvidia"



cuentafinal 1 "Creando Usuario Principal de Tron..."
echo Introduzca el nombre del usuario:
read $usuario
adduser $usuario
gpasswd -a $usuario sudo
echo "Ingrese Password"
passwd
usuario=${SUDO_USER:-${USER}}

apt-get install -y grub-pc grub-pc-bin grub2-common



#apt -y install figlet toilet 

#let con++
#{
#figlet -c "Parte $con"
#echo
#echo
#cuentafinal 9 *** "Parte 4: Instalado Sistema Básico ---->>> Sigue: Instalación de Escritorio ***"
#echo
#echo
#echo
#echo
#echo ***************************************************************
#apt install -y xubuntu-desktop ubuntu-standard nano 
##dpkg-reconfigure resolvconf    
#dpkg-reconfigure network-manager
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-InstalarUbuntu-Xubuntu-Escritorio.log
#preguntasalir "Ver el log de Instalación Xubuntu"










#{
#figlet -c "Parte $con"
#echo 
#echo

#cuentafinal 3 "************************Copiando Tron a home/tron..."
#mv -v /home/tron /home/$usuario/tron
#cuentafinal 2 "Instalando Tron Bash Plugin..."
#ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /etc/
#ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /root/.bashrc
#ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /home/.bashrc
#ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /root/bash.bashrc
#ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /home/bash.bashrc
#source .bashrc
#cuentafinal 3 "*************************Instalando Tron dependencias"
#apt install -y gedit gedit-plugin-terminal gedit-plugin-text-size gedit-plugin-synctex gedit-plugin-session-saver gedit-plugin-multi-edit gedit-plugin-join-lines gedit-plugin-git gedit-plugin-find-in-files gedit-plugin-draw-spaces gedit-plugin-color-schemer gedit-plugin-color-picker gedit-plugin-code-comment gedit-plugin-character-map gedit-plugin-bookmarks gedit-dev gedit-common zenity kdialog gedit-source-code-browser-plugin gedit-plugins-common gedit-plugins gedit-plugin-word-completion
#cuentafinal 3 "**************************Instalando Variables Tron..."
#source "/home/$usuario/tron/plugins/bash/bashVariables.sh" 
#cuentafinal 3 creando enlaces a externals tools de gedit...
#ln -v --backup --suffix=_res -f /home/$usuario/tron/plugins/gedit/* /usr/share/gedit/plugins/externaltools/tools/
#ln -v --backup --suffix=_res -f /home/$usuario/tron/funciones/* /usr/share/gedit/plugins/externaltools/tools/
#ln -v --backup --suffix=_res -f /home/$usuario/tron/plugins/gedit-snipets/* /usr/share/gedit/plugins/snippets/
#ln -v --backup --suffix=_res -f /home/$usuario/tron/plugins/bash/bashVariables.sh /home/$usuario/tron/plugins/admScripts
#cuentafinal 3 MOVIENDO RESPALDOS...
#mv -v -f /usr/share/gedit/plugins/externaltools/tools/*_res* /home/$usuario/tron/zzRespaldosDeLn/
#mv -v -f /usr/share/gedit/plugins/snippets/*_res* /home/$usuario/tron/zzRespaldosDeLn/
#mv -v -f /home/$usuario/tron/plugins/admScripts/*_res* /home/$usuario/tron/zzRespaldosDeLn/
#echo
#echo
#cuentafinal 3 "**************************OTORGANDO PERMISOS..."
#echo 
#chown -R -c -H -h -L $usuario:$usuario "$geditSis"
#chown -R -c -H -h -L $usuario:$usuario "/home/$usuario/tron/plugins/bash"
#chown -R -c -H -h -L $usuario:$usuario "/home/$usuario/tron/plugins/gedit"
#chown -R -c -H -h -L $usuario:$usuario "/home/$usuario/tron/plugins/gedit-snipets"
#chown -R -c -H -h -L $usuario:$usuario "$geditSnippets"
#chmod -R -c 755 "$geditSis"
#chmod -R -c 755 "/home/$usuario/tron/plugins/bash"
#chmod -R -c 755 "/home/$usuario/tron/plugins/gedit"
#chmod -R -c 755 "/home/$usuario/tron/plugins/gedit-snipets"
#echo  "Activando las funciones de este Script con tron.."
#sleep 4
#source /home/$usuario/tron/plugins/bash/bashFunciones.sh
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-InstalarUbuntu-Tron.log
#preguntasalir "Ver el log de Instalacion de Tron"











#cuentafinal 5 "****************************Configurando locales..."
#export LC_CTYPE=es_ES.UTF-8
#export LC_ALL=es_ES.UTF-8
#export LANGUAGE=es_ES.UTF-8
#export LANG=es_ES.UTF-8
#dpkg-reconfigure keyboard-configuration
#dpkg-reconfigure tzdat
#dpkg-reconfigure locales
##locale-gen
##locale-gen es_ES.UTF-8
##dpkg-reconfigure locales
##apt-get update &&  apt-get -y full-upgrade










#let con++
#{
#figlet -c "Parte $con"
#cuentafinal 9 "Instalación de Llaves..."
#apt install -y curl gnupg software-properties-common
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DD3C368A8DE1B7A0
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C6E74D6C0A35108
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DD3C368A8DE1B7A0
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4C6E74D6C0A35108
#wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
#add-apt-repository 'deb https://deb.opera.com/opera-stable/ stable non-free'
#apt install apt-transport-https
#wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
#wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.de
#add-apt-repository -y ppa:team-xbmc/ppa
#add-apt-repository -y ppa:flatpak/stable
#apt update
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-InstalarUbuntu-Llaves.log
#preguntasalir "Ver el log de Instalacion de Las llaves"



#let con++
#{
#figlet -c "Parte $con"
## INICIO INSTALACIONES INTERACTIVAS
#cuentafinal 2 "INSTALACIONES INTERACTIVAS"
#sudo apt -y install tasksel
#tasksel
## FIN INSTALACIONES INTERACTIVAS
#echo ***********************Instalando Streaming de audio
#AgregarFinal "load-module module-simple-protocol-tcp source=0 record=true port=12345" /etc/pulse/default.pa
#pulseaudio -k
#pulseaudio --start 
#cuentafinal 2 "FIN INSTALACIONES INTERACTIVAS"
#npm install -g firebase-tools
##Para instalar linux from scratch (Linux desde Linux)
#apt install -y debootstrap code flatpak htop git unzip
##Instalando Jellyfin
#cuentafinal 4 "INSTALANDO JELLYFIN"

#mkdir /etc/apt/keyrings
#curl -fsSL https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release )/jellyfin_team.gpg.key | gpg --dearmor -o /etc/apt/keyrings/jellyfin.gpg
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys
#apt update
#apt install -y jellyfin
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-Interactive-Apps.log
#preguntasalir "Ver el log de Instalacion de Las Interactive Apps"





#let con++
#{
#figlet -c "Parte $con"
#echo *****************************Instalando  Driver de Usb Wifi*************
#cuentafinal 3 "INSTALANDO USB WIFI"
##/bin/bash /path/to/script
##source /path/to/script
##EL PRIMER COMANDO EJECUTA EL SEGUNDO SCRIPT EN EL MISMO PROCESO 
##CUANDO SE SALE CON EXIT DEL SEGUNDO SCRIPT SE SALE DEL PRIMERO 
##EL SEGUNDO EJECUTA EL SEGUNDO SCRIPT EN UN PROCESO APARTE CUANDO SE SALE DEL SEGUNDO SCRIPT
## CON EXIT NO SE SALE DEL PRIMERO
#instalar(){
#DRV_DIR=`pwd`
#DRV_NAME=rtl8821CU
#DRV_VERSION=5.4.1
#echo la var 1 es: ${DRV_DIR}
#echo la var 2 es: ${DRV_NAME}-${DRV_VERSION}
#cp -r -v ${DRV_DIR} /usr/src/${DRV_NAME}-${DRV_VERSION}
#cp -v dkms.conf /usr/src/rtl8821CU-5.4.1/
#dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
#dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
#dkms install -m ${DRV_NAME} -v ${DRV_VERSION}
#RESULT=$?
#echo "Finished running dkms install steps."
#if grep -q -e "^CONFIG_DISABLE_IPV6 = y$" "$DRV_DIR/Makefile" ; then
#	if echo "net.ipv6.conf.all.disable_ipv6 = 1
#  net.ipv6.conf.default.disable_ipv6 = 1
#  net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf; then
#		echo "Disabled IPv6 Successfuly "
#		sysctl -p
#        return
#	else
#		echo "Could not disable IPv6"
#        return
#	fi
#fi
#echo TERMINA EL SCRIPT INSTALACIÓN USB WIFI
#return
#}
#desintalar () {
#if [[ $EUID -ne 0 ]]; then
#  echo "You must run this with superuser priviliges.  Try \"sudo ./dkms-remove.sh\"" 2>&1
#  exit 1
#else
#  echo "About to run dkms removal steps..."
#fi
#DRV_DIR=rtl8821CU
#DRV_NAME=rtl8821CU
#DRV_VERSION=5.4.1
#dkms remove ${DRV_NAME}/${DRV_VERSION} --all
#rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}
#RESULT=$?
#if [[ "$RESULT" != "0" ]]; then
#  echo "Error occurred while running dkms remove." 2>&1
#    return
#else
#  echo "Finished running dkms removal steps."
#    return
#fi
#return
#}
#cuentafinal 5 "******************************INSTALANDO USB WIFI"
#echo Iniciando instalacion dkms
#apt install -y dkms
#echo Finalizando instalacion dkms
##sudo -u $usuario git clone https://github.com/brektrou/rtl8821CU.git
#unzip -o /home/$usuario/tron/Drivers/rtl8821CU.zip -d /home/$usuario/tron/Drivers/Build/
#cd /home/$usuario/tron/Drivers/Build/rtl8821CU
##cp -a -p -f -v /home/dkms-install.sh /home/$usuario/tron/plugins/build/rtl8821CU/dkms-install.sh
##para desintalar solo coloque aca  la palabra desintalar
#instalar
#rm -d -v -r -f /home/$usuario/tron/Drivers/Build/rtl8821CU
#rm -d -v -r -f /home/$usuario/tron/Drivers/Build/rtl8821CU.zip
#cuentafinal 2 "****************************FIN INSTALACION USB WIFI"
#echo ***************************************************************
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-Install-USB.log
#preguntasalir "Ver el log de Instalacion de Wifi Usb"






#let con++
#{
#figlet -c "Parte $con"
#cuentafinal 5 "************************ INSTALANDO PROGRAMAS DIVERSOS **"
#apt purge -y firefox
#apt install -y snap synaptic dolphin curl lynx gjs gnome-terminal desktop-file-utils zip evince lynx imagemagick-6.q16 exif android-tools-adb grub-imageboot clamav xarchiver node-shebang-command sqlite3 yad socat gparted unrar libreoffice-l10n-es libreoffice-templates apt-transport-https gnome-disk-utility ufw build-essential zlib1g-dev libgdbm-dev libncurses5-dev libssl-dev libnss3-dev libffi-dev libreadline-dev wget libsqlite3-dev libbz2-dev

#cuentafinal 2 "CONFIGURANDO EL FIREWALL"
##CONFIGURANDO EL FIREWALL
#ufw enable
##  ufw allow Apache
#ufw allow OpenSSH
## ufw allow 8245/tcp
#service ufw restart
#cuentafinal 3 "DESACTIVANDO LAS ACTUALIZACIONES AUTOMÁTICAS"
##DESACTIVANDO LAS ACTUALIZACIONES AUTOMÁTICAS
## apt-daily
#systemctl stop apt-daily.timer
#systemctl disable apt-daily.timer
# # apt-daily-upgrade
#systemctl stop apt-daily-upgrade.timer
#systemctl disable apt-daily-upgrade.timer
## programa para ver los csv en la terminal y mas
#npm i -g tty-table
#cuentafinal 5 "Instalando Tienda de Software"
#apt install -y /home/$usuario/tron/plugins/tienda/app-outlet_2.1.0_amd64.deb
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-Programas-Diversos.log
#preguntarsalir "Ver log Programas diversos"




#cuentafinal 4 "Actualizando /etc/hosts"
#cp -a -p -f -v /home/$usuario/tron/plugins/system/hosts /etc/
#ln /home/$usuario/tron/plugins/system/hosts /etc/host





#let con++
#{
#figlet -c "Parte $con"
#cuentafinal 10 "INSTALANDO PYTHON"
#echo **************************************************INSTALANDO PYTHON
#tar xzvf /home/$usuario/tron/plugins/python/Python-3.11.0.tgz --directory=/home/$usuario/tron/plugins/python/
#cd /home/$usuario/tron/plugins/python/Python-3.11.0
##sudo -u $usuario ./configure --enable-optimizations --with-lto
##Tomado de https://www.build-python-from-source.com/
## Otra a probar https://ubuntuhandbook.org/index.php/2021/10/compile-install-python-3-10-ubuntu/
#cuentafinal 10 "CONFIGURANDO PYTHON"
#sudo -u $usuario ./configure --enable-shared
##sudo -u $usuario ./configure
#cuentafinal 10 "MAKE PYTHON"
#sudo -u $usuario make
##sudo -u $usuario make
#cuentafinal 10 "MAKE AltInstall"
#sudo -u $usuario make altinstall
##sudo -u $usuario make test
#cuentafinal 10 "************************INSTALANDO PYTHON CON ALTERNATIVE INSTALL"
##make altinstall
##/opt/python/3.11.0/bin/python3.11 -m pip install --upgrade pip setuptools wheel
##ln -s /opt/python/3.11.0/bin/python3.11        /opt/python/3.11.0/bin/python3
##ln -s /opt/python/3.11.0/bin/python3.11        /opt/python/3.11.0/bin/python
##ln -s /opt/python/3.11.0/bin/pip3.11           /opt/python/3.11.0/bin/pip3
##ln -s /opt/python/3.11.0/bin/pip3.11           /opt/python/3.11.0/bin/pip
##ln -s /opt/python/3.11.0/bin/pydoc3.11         /opt/python/3.11.0/bin/pydoc
##ln -s /opt/python/3.11.0/bin/idle3.11          /opt/python/3.11.0/bin/idle
##ln -s /opt/python/3.11.0/bin/python3.11-config      /opt/python/3.11.0/bin/python-config
##sudo make altinstall
##cuentafinal 10 "INSTALANDO PYTHON PIP Y MODULOS"
#sudo -u $usuario $python_ver -m pip install --upgrade pip
#sudo -u $usuario $python_ver -m pip install -U autopep8
#sudo -u $usuario $python_ver -m pip install ffpyplayer
#sudo -u $usuario $python_ver -m pip install kivy
#sudo -u $usuario $python_ver -m pip install kivymd
#sudo -u $usuario $python_ver -m pip install tk
#sudo -u $usuario $python_ver -m pip install tkinter

#rm -r -d -v /home/$usuario/tron/plugins/python/Python-3.11.0
#} 2>&1 | tee /home/daniel/tron/install/logs/InstallUbuntu/$con-Install-Python.log
#preguntarsalir "Ver log Install Python"

export PS1="(chroot) $PS1"





echo "***************************Desmontando Particiones"
echo
echo
umount -lf /proc
umount -lf /sys
umount -lf /dev/pts
umount -lf /dev
echo
echo
exit
# //////////////////////////////////////// FIN SCRIPT/////////////////////////////////////////////////////////



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



##apt-get install -y language-pack-en-base
#echo ***************************Generando ID DE máquina
#rm -f /etc/machine-id /var/lib/dbus/machine-id
#dbus-uuidgen --ensure=/etc/machine-id
#dbus-uuidgen --ensure


#echo ****************************Limpiando Kernels Antiguos
#ls /boot/vmlinuz-2.6.**-**-generic > list.txt
#sum=$(cat list.txt | grep '[^ ]' | wc -l)
#if [ $sum -gt 1 ]; then
#dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
#fi



# Programas2023 Instalación general de las aplicaciones y programas necesarios
#Para el funcionamiento de tu profesión y
#El Trabajo diario con la computadora.
#apt-get install -y grub-pc
#apt-get install -y libterm-readline-gnu-perl
#apt-get install -y systemd-sysv
#apt-get install -y sudo
#apt-get install -y ubuntu-standard
#apt-get install -y casper
#apt-get install -y lupin-casper
#apt-get install -y discover
#apt-get install -y laptop-detect
#apt-get install -y os-prober
#apt-get install -y network-manager
#apt-get install -y resolvconf
#apt-get install -y net-tools
#apt-get install -y wireless-tools
#apt-get install -y wpagui
#apt-get install -y locales
#apt-get install -y grub-common
#apt-get install -y grub-gfxpayload-lists
#apt-get install -y grub-pc
#apt-get install -y grub-pc-bin
#apt-get install -y grub2-common
#apt-get install -y ubiquity
#apt-get install -y ubiquity-casper
#apt-get install -y ubiquity-frontend-gtk
#apt-get install -y ubiquity-slideshow-ubuntu
#apt-get install -y ubiquity-ubuntu-artwork

