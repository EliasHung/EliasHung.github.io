#!/bin/bash
	
if [[ ! -f "$scripts/BajoNivel.sh" ]]; then
    source /home/tron/Scripts/BajoNivel.sh

else
    source $scripts/BajoNivel.sh
fi
#FUNCIONES DEBAJO DE ESTO POR FAVOR

 # Sincroniza los documentos de Tron a Mkdocs en biblioteca
 # Construye Mkdocs, utiliza la libreria sincro
 # Sincroniza todos los .md desde tron hasta mkdocs conservando el árbol de carpetas.
 # Los enlaces son enlaces duros, es decir la docu dentro de tron se sincroniza
 #  automaticamente con mkdocs


# TODO controlar los procesos abiertos con las funciones ya creadas.
prx () {
    aux=$PWD
    cd /home/$usuario/tron/programas/heuristic
    markserv Leeme.md > /dev/null 2>&1 &
    abrirsesionWeb  > /dev/null 2>&1 &
    activarentorno "Mkdocs"
    cd /home/$usuario/tron/biblioteca/mkdocs
    python3 -m mkdocs serve > /dev/null 2>&1 &
    crom http://127.0.0.1:8000 > /dev/null 2>&1 &
    micro /home/$usuario/tron/programas/heuristic/Leeme.md
    cd $aux
}



crearentorno () {
    cd $plugins/python/entornos
    echo "Ingrese el nombre del entorno"
    read nombre
    python3 -m venv $nombre
}

# Activa un entorno env python existente
# $1 cadena que indica el nombre de del entorno a ser activado
# sino recibe $1 entonces pregunta que entorno activar
activarentorno () {
    aux=$PWD
        
    cd $plugins/python/entornos
    echo
    
    if [[ -z $1 ]]; then
        ls
        echo
        echo "¿Que entorno desea activar?"
        read nombre
        cd $PWD/$nombre
    else
        cd $PWD/$1
    fi
    cd bin
    var="source activate"
    eval "$var"
    cd $PWD
        
    }

sshGit () {
        echo "ver mi llave ssh"
        eval $(ssh-agent -s)

        echo "crear la llave ssh para git"
        echo "ingrese el correo de git"
        echo "puede ser elias1hung@gmail.com"
        read correo

        ssh-keygen -t ed25519 -C $correo 

        echo "agregar la llave al servicio de llaves"
        ssh-add ~/.ssh/id_ed25519

        echo 'la llave esta guardada en  ~/.ssh/id_ed25519.pub'

        echo "mostrando el contenido de la llave"  
        cat ~/.ssh/id_ed25519.pub

        echo "esa llave es la que se coloca en el sitio web de git"
}


DeshabilitarAhorroEnergiaNetworkManager () {

#NM_SETTING_WIRELESS_POWERSAVE_DEFAULT (0): utilice el valor predeterminado
#NM_SETTING_WIRELESS_POWERSAVE_IGNORE (1): no toque la configuración existente
#NM_SETTING_WIRELESS_POWERSAVE_DISABLE (2): deshabilitar ahorro de energía
#NM_SETTING_WIRELESS_POWERSAVE_ENABLE (3): habilitar ahorro de energía
sudo sed -i 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf || systemctl restart network-manager.service
echo
echo El ahorro de energia Network MAnager es:
cat /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf


}



descomprimayuse () {
mkdir /home/daniel/tron/plugins/navegadores
chown daniel:daniel  /home/daniel/tron/plugins/navegadores
file="/home/$usuario/tron/plugins/ComprimidosO.deb/firefox-108.0b9.tar.bz2"
destino="/home/$usuario/tron/plugins/navegadores/"
sudo -u $usuario unar -f -o $destino $file
file="/home/$usuario/tron/plugins/ComprimidosO.deb/rtl8821CU.zip"
destino="/home/$usuario/tron/Drivers/"
mkdir /home/$usuario/tron/Drivers
chown daniel:daniel  /home/$usuario/tron/Drivers
sudo -u $usuario unar -f -o $destino $file
}



InstallWifiUsb () {
instalarWifiUsb 1 /home/$usuario/tron/Drivers
}

# $1= 1 (para inslalar) 0 (para desintalar)
instalarWifiUsb () {
#   if [[ $EUID -ne 0 ]]; then
#      echo "Debe ser root para correr este script, trate: \"sudo ./dkms-install.sh\"" 2>&1
#      return 1
#    fi

    Carpeta_Instalador=$2
    
    cd $Carpeta_Instalador


    if [[ -z $1 || -z $2 || ! -d $Carpeta_Instalador ]]; then 
        echo "Uso: instalarWifiUsb 1 [rutaCarpeta_Instalador] para instalar."
        echo
        echo "instalarWifiUsb 0 [rutaCarpeta_Instalador] para desinstalar."
        echo
        echo "[rutaCarpeta_Instalador] es la carpeta donde se descomprimirá el"
        echo "Driver."
        return 1
    fi





    if [ $1 == 1 ]; then
#        rm -r -v -d -f rtl8821CU
#        descomprimir rtl8821CU.zip
        ejecutarcomoroot


        cd rtl8821CU


        if [[ $EUID -ne 0 ]]; then
          echo "Debe ser root para correr este script, trate: \"sudo ./dkms-install.sh\"" 2>&1
          
        else
          echo "About to run dkms install steps..."
        fi


        DRV_DIR=`pwd`
        DRV_NAME=rtl8821CU
        DRV_VERSION=5.4.1
        aux1='cp -r'

        cp -r ${DRV_DIR} /usr/src/${DRV_NAME}-${DRV_VERSION}
        echo "EL comando es : $aux1 ${DRV_DIR} /usr/src/${DRV_NAME}-${DRV_VERSION}"

        dkms add -m ${DRV_NAME} -v ${DRV_VERSION}

        dkms build -m ${DRV_NAME} -v ${DRV_VERSION}

        dkms install -m ${DRV_NAME} -v ${DRV_VERSION}

        RESULT=$?

        echo "Finished running dkms install steps."

        if grep -q -e "^CONFIG_DISABLE_IPV6 = y$" "$DRV_DIR/Makefile" ; then
	        if echo "net.ipv6.conf.all.disable_ipv6 = 1
          net.ipv6.conf.default.disable_ipv6 = 1
          net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf; then
		        echo "Disabled IPv6 Successfuly "
		        sysctl -p
	        else
		        echo "Could not disable IPv6"
	        fi
        fi
	
	instalarwifi2 $Carpeta_Instalador
        return $RESULT
    fi

#DESINTALAR
    if [ $1 == 0 ]; then
        cd rtl8821CU
        ejecutarcomoroot
        if [[ $EUID -ne 0 ]]; then
          echo "Debe ser root para correr este script, trate: \"sudo ./dkms-install.sh\"" 2>&1
          return 1
        else
          echo "About to run dkms removal steps..."
        fi

        DRV_DIR=rtl8821CU
        DRV_NAME=rtl8821CU
        DRV_VERSION=5.4.1

        dkms remove ${DRV_NAME}/${DRV_VERSION} --all
        rm -rf /usr/src/${DRV_NAME}-${DRV_VERSION}

        RESULT=$?
        if [[ "$RESULT" != "0" ]]; then
          echo "Error occurred while running dkms remove." 2>&1
        else
          echo "Finished running dkms removal steps."
        fi

        return $RESULT
        

    fi



}

# $1 carpeta instalador
instalarwifi2() {
cd $1
usb_modeswitch -KW -v 0bda -p c811
cp-igualito /home/$usuario/tron/config/40-usb_modeswitch.rules /lib/udev/rules.d/

cd rtl8821CU
make

make install


}

installBash () {
# NOTA: Al modificar esta funcion debes modificar
# la funcion installBash del script de mudanza
inicio=$PWD
cd /home
sudo rm -v /etc/.bashrc; sudo rm -v /etc/.bash.bashrc; sudo rm -v /root/.bashrc; sudo rm -v /home/.bashrc; sudo rm -v /home/.bash.bashrc
sudo rm -v /etc/.bashrc; sudo rm -v /etc/.bash.bashrc; sudo rm -v /root/.bashrc; sudo rm -v /home/.bashrc; sudo rm -v /home/.bash.bashrc

# en /home
sudo cp -a -p -f -v /home/$usuario/tron/plugins/bash/bash.bashrc /home/.bashrc
sudo cp -a -p -f -v /home/$usuario/tron/plugins/bash/bash.bashrc /home/.bash.bashrc
sudo chown  -v root:root /home/.bashrc; sudo chmod  -v 755 /home/.bashrc
sudo chown  -v root:root /home/.bash.bashrc; sudo chmod  -v 755 /home/.bash.bashrc

# en /etc
sudo cp -a -p -f -v /home/$usuario/tron/plugins/bash/bash.bashrc /etc/.bashrc
sudo cp -a -p -f -v /home/$usuario/tron/plugins/bash/bash.bashrc /etc/.bash.bashrc
sudo chown  -v root:root /etc/.bashrc; sudo chmod  -v 755 /etc/.bashrc
sudo chown  -v root:root /etc/.bash.bashrc; sudo chmod  -v 755 /etc/.bash.bashrc

# para el usuario root
sudo cp -a -p -f -v /home/$usuario/tron/plugins/bash/bash.bashrc /root/.bashrc
sudo cp -a -p -f -v /home/$usuario/tron/plugins/bash/bash.bashrc /root/.bash.bashrc
sudo chown  -v root:root /root/.bashrc; sudo chmod  -v 755 /root/.bashrc
sudo chown  -v root:root /root/.bash.bashrc; sudo chmod  -v 755 /root/.bash.bashrc

source /home/.bashrc
source .bashrc
ln -v -f /home/daniel/tron/plugins/bash/* $Scripts/
cd $inicio
}



installBashenlace () {
ejecutarcomoroot
ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /etc/.bashrc
ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /etc/bash.bashrc
ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /root/.bashrc
ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /home/.bashrc
ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /root/bash.bashrc
ln -v -b -f /home/$usuario/tron/plugins/bash/bash.bashrc /home/bash.bashrc

}


implementar () {


#PARA QUE FUNCIONE PRIMERO INSTALE BASH
#sustituya $usuario="nombre_usuario" 
ejecutarcomoroot

source "/home/$usuario/tron/plugins/bash/bashVariables.sh" 
#cuentafinal 2 "creando enlaces a externals tools de gedit..."

#ln -v --backup --suffix=_res -f /home/$usuario/tron/tron/sesiones /usr/share/gedit/plugins/externaltools/tools/
##ln -v --backup --suffix=_res -f $funciones/* /usr/share/gedit/plugins/externaltools/tools/
##ln -v --backup --suffix=_res -f $plugins/gedit-snipets/* /usr/share/gedit/plugins/snippets/
##ln -v --backup --suffix=_res -f $plugins/bash/bashVariables.sh $tronscripts

#echo
#echo
cuentafinal 2 "MOVIENDO RESPALDOS**************MOVIENDO RESPALDOS***********MOVIENDO RESPALDOS"
echo 
mv -v -f /usr/share/gedit/plugins/externaltools/tools/*_res* $respaldosln/
#mv -v -f /usr/share/gedit/plugins/snippets/*_res* $respaldosln/
#mv -v -f /home/$usuario/tron/plugins/admScripts/*_res* $respaldosln/
echo
echo
cuentafinal 3 "PERMISOS**************PERMISOS***********PERMISOS"
echo 
chown -R -c -H -h -L $usuario:$usuario "$geditSis"
chown -R -c -H -h -L $usuario:$usuario "$tronbash"
#chown -R -c -H -h -L $usuario:$usuario "$trongedit"
#chown -R -c -H -h -L $usuario:$usuario "$plugins/gedit-snipets"
#chown -R -c -H -h -L $usuario:$usuario "$geditSnippets"
chmod -R -c 755 "$geditSis"
chmod -R -c 755 "$plugins/bash"
#chmod -R -c 755 "$plugins/gedit"
#chmod -R -c 755 "$plugins/gedit-snipets"

echo 
echo TRON:
echo tu y yo defendemos y amamos a la humanidad.
echo Yo soy TRON yo defiendo al Usuario.
echo Tron: enlaces creados, permisos otorgados...

}

LevantarStreamingAudio () {
cuentafinal 2 "lista de fuentes de audio"
pactl list sources short
cuentafinal 2 "Desbloqueando Firewal"
sudo ufw allow 12345/tcp
cuentafinal 2 "'Ejecutando pactl load-module module-detect'"
pactl load-module module-detect
cuentafinal 2 "Reiniciando el Audio"
pulseaudio -k
pulseaudio --start 

}

streamingAudio () {

AgregarFinal "load-module module-simple-protocol-tcp source=0 record=true port=12346" /etc/pulse/default.pa
sudo -u $usuario pulseaudio -k
sudo -u $usuario pulseaudio --start

}




configurafirewall () {


cuentafinal 2 "CONFIGURANDO EL FIREWALL"
#CONFIGURANDO EL FIREWALL
ufw enable
#  ufw allow Apache
ufw allow OpenSSH
# ufw allow 8245/tcp

ufw allow ssh
service ufw restart
}




correo () {
    #Programa para recibir
    #el correo de el telefono desde
    #la bandeja de salida del mismo
    #en la carpetad destino
    #autor: Elias hung
    #elprofesorverdad@gmail.com
    #
    #
    if [[ ! -d $escritorio/BandejadeEntrada ]]; then
        mkdir $escritorio/BandejadeEntrada
    fi
    if [[ ! -d $escritorio/BandejadeSalida ]]; then
        mkdir $escritorio/BandejadeSalida
    fi
    
    usuario="daniel"
    respaldo="/home/$usuario/respaldo"
    salidaTelefono="/sdcard/A1BandejaDeSalida"
    entradaCompu="$escritorio/BandejadeEntrada"
    entradaTelefono="/sdcard/A1BandejaDeEntrada"
    salidaCompu="$escritorio/BandejadeSalida"
    #
    salidaTelefonoPelis="/sdcard/A1pelis"
    entradaCompuPelis="/mnt/sdc"
    #entradaTelefonoPelis="sdcard/A1BandejaDeEntrada"
    #salidaCompuPelis="/home/daniel/Escritorio/PARA_EL_TELEFONO"

    if [[ -z $1  ]];
    then
			    echo por favor mi usuario: $usuario elija una opción válida
			    echo opción 'ern' para enviar y recibir y abrir el navegador de archivos
			    echo opción 'r' Solo recibir
			    echo opción 'e' Solo enviar
			    echo opcion 'r2' Recibir documentos y películas
			    echo opción 'pd' Películas Descargar
			    echo "**********OPCIONES PARA PELICULAS***********"
    #	echo opción '-ps' Películas Subir
    else
	    adb start-server
	    case $1 in
		    "ern")
			    adb pull "$salidaTelefono" "$entradaCompu"
			    adb push "$salidaCompu" "$entradaTelefono"
			    thunar $entradaCompu
		    ;;
		    "e")
			    
			    adb push "$salidaCompu" "$entradaTelefono" 
		    ;;
		    "r")
			    adb pull "$salidaTelefono" "$entradaCompu"
   			    thunar $entradaCompu

		    ;;
		    #"-ps")
		    #	adb push "$salidaCompuPelis"/* "$entradaTelefonoPelis" 
    #		;;
		    "pd")
			    adb pull "$salidaTelefonoPelis" "$entradaCompuPelis"
		    ;;
		    "r2")
			    adb pull "$salidaTelefonoPelis" "$entradaCompuPelis"
			    adb pull "$salidaTelefono" "$entradaCompu"
		    ;;
		    *)
			    echo por favor mi usuario: $usuario elija una opción válida
			    echo opción 'ern' para enviar y recibir y abrir el navegador de archivos
			    echo opción 'r' Solo recibir
			    echo opción 'e' Solo enviar
			    echo opcion 'r2' Recibir documentos y películas
			    echo opción 'pd' Películas Descargar
			    echo "**********OPCIONES PARA PELICULAS***********"
			    
				    
		    ;;
	    esac 
    fi
}


correow () {
    #Programa para recibir
    #el correo de el telefono desde
    #la bandeja de salida del mismo
    #en la carpetad destino
    #autor: Elias hung
    #elprofesorverdad@gmail.com
    #
    #
    if [[ ! -d $escritorio/BandejadeEntrada ]]; then
        mkdir $escritorio/BandejadeEntrada
    fi
    if [[ ! -d $escritorio/BandejadeSalida ]]; then
        mkdir $escritorio/BandejadeSalida
    fi
    
    usuario="daniel"
    respaldo="/home/$usuario/respaldo"
    salidaTelefono="/sdcard/A1BandejaDeSalida"
    entradaCompu="$escritorio/BandejadeEntrada"
    entradaTelefono="/sdcard/A1BandejaDeEntrada"
    salidaCompu="$escritorio/BandejadeSalida"
    #
    salidaTelefonoPelis="/sdcard/A1pelis"
    entradaCompuPelis="/mnt/sdc"
    #entradaTelefonoPelis="sdcard/A1BandejaDeEntrada"
    #salidaCompuPelis="/home/daniel/Escritorio/PARA_EL_TELEFONO"

    if [[ -z $1  ]];
    then
			    echo por favor mi usuario: $usuario elija una opción válida
			    echo opción 'ern' para enviar y recibir y abrir el navegador de archivos
			    echo opción 'r' Solo recibir
			    echo opción 'e' Solo enviar
			    echo opcion 'r2' Recibir documentos y películas
			    echo opción 'pd' Películas Descargar
			    echo "**********OPCIONES PARA PELICULAS***********"
    #	echo opción '-ps' Películas Subir
    else
	    adb start-server
	    adb connect 172.16.0.150:5555
	    case $1 in
		    "ern")
			    adb pull "$salidaTelefono" "$entradaCompu"
			    adb push "$salidaCompu" "$entradaTelefono"
			    thunar $entradaCompu
		    ;;
		    "e")
			    
			    adb push "$salidaCompu" "$entradaTelefono" 
		    ;;
		    "r")
			    adb pull "$salidaTelefono" "$entradaCompu"
   			    thunar $entradaCompu

		    ;;
		    #"-ps")
		    #	adb push "$salidaCompuPelis"/* "$entradaTelefonoPelis" 
    #		;;
		    "pd")
			    adb pull "$salidaTelefonoPelis" "$entradaCompuPelis"
		    ;;
		    "r2")
			    adb pull "$salidaTelefonoPelis" "$entradaCompuPelis"
			    adb pull "$salidaTelefono" "$entradaCompu"
		    ;;
		    *)
			    echo por favor mi usuario: $usuario elija una opción válida
			    echo opción 'ern' para enviar y recibir y abrir el navegador de archivos
			    echo opción 'r' Solo recibir
			    echo opción 'e' Solo enviar
			    echo opcion 'r2' Recibir documentos y películas
			    echo opción 'pd' Películas Descargar
			    echo "**********OPCIONES PARA PELICULAS***********"
			    
				    
		    ;;
	    esac 
    fi
adb disconnect 172.16.0.150:5555
adb kill-server
}


hardware ()
{
echo INFORMACION DE HARDWARE
echo
echo Cómo verificar la información sobre el
echo hardware en Linux
echo
echo Comando lscpu – Procesamiento
echo lshw – Lista de hardware en Linux
echo hwinfo – Información del hardware en 
echo Linux
echo lspci – Lista PCI
echo lsscsi – Listar dispositivos scsi
echo lsusb – Lista de los buses usb y 
echo detalles del echo dispositivo
echo Inxi
echo lsblk – Lista de dispositivos de bloque
echo df – espacio en disco de los sistemas de archivos
echo Pydf – Python df
echo fdisk
echo free – Verifica la RAM
echo hdparm – Información de disco duro

}


funSincronizar ()
{
/usr/bin/syncthing serve --no-browser --logfile=default &
disown
fire http://127.0.0.1:8384

}



imagenInformacion ()
{

 	if [[ -z $1 ]];
	then
		#ruta=$PWD
		echo Error: Ingrese la ruta completa de la Imagen desde la raiz
		
	else
		ruta=$1
		echo "# PROGRAMA ELABORADO POR DANIEL HUNG"  >> infoima
		echo "# MUESTRA LA INFORMACION DE UNA IMAGEN"  >> infoima
		echo "#" >> infoima
		echo "#" >> infoima
		echo "#" >> infoima
		echo VALORES POR IMAGEMAGICK >> infoima 
			echo >> infoima
			echo >> infoima
			identify -verbose $ruta >> infoima 2>&1
			echo >> infoima
			echo >> infoima
		echo VALORES POR FILE >> infoima
			echo >> infoima
			echo >> infoima
			file $ruta >> infoima 2>&1
			echo >> infoima
			echo >> infoima
		echo VALORES POR EXIF >> infoima
			echo >> infoima
			echo >> infoima
			exif $ruta >> infoima 2>&1
			echo >> infoima
			echo >> infoima
		editar infoima
	fi
		rm infoima >> infoima 2>&1
	
 	
 	
 }
 
troncontanque ()
{

#el antivirus Escanea la carpeta pasada como argumento
# comprueba si se ha pasado la ruta como argumentu si el argumento es vacio se toma la ruta actual
if [[ -z $1 ]];
then
	ruta=$PWD
else
	ruta=$1
fi

echo "presione 1 solo solo analizar los archivos y 2 para analizar y borrar los virus"
read frase

case $frase in
  1)
    clamscan -r  -v -a $ruta
  ;;
  2)
    clamscan --infected --remove --recursive  -v -a $ruta
 ;;
esac
       
 }


 analizar ()
 {
 	#el antivirus Escanea la carpeta pasada como argumento
 	# comprueba si se ha pasado la ruta como argumentu si el argumento es vacio se toma la ruta actual
	if [[ -z $1 ]];
	then
  		ruta=$PWD
	else
		ruta=$1
 	fi
  
   	# 

       #
       #alert $ruta
	yad --title="ASISTENTE: SR HUNG" \
    	--center \
    	--width=500 \
    	--height=80 \
    	--text-align=center \
        --button=Si:0 \
        --button=No:1 \
    	--text="¿Desea Seguro desea Analizar: $ruta ?"
	ans=$?

	if [ $ans -eq 0 ]
	then

		yad --title="ASISTENTE: SR HUNG" \
    		--center \
    		--width=500 \
    		--height=80 \
    		--text-align=center \
       		 --button=SoloEscanear:0 \
        	--button=EliminarArchivosInfectados:1 \
    		--text="¿Desea Solo Escanear O Escanear y Eliminar Amenazas en  $ruta ?"
		ans=$?

		if [ $ans -eq 0 ]
		then
    		
                	clamscan -r  -v -a --log=/home/logAntivirus.txt $ruta
		else
    			clamscan --infected --remove --recursive  -v -a --log=/home/logAntivirus.txt $ruta
		fi

	else
    		return 0
	fi
       
 } 
 



