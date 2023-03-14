# ex: prefijo ruta sistema externo
# hs: idem sistema host
#cambiado  adrede
source quinetaleenubu18sencillo.sh
hsusuario=${SUDO_USER:-${USER}} 
#FUNCIONES

desea () {
    echo "Desea $1 ...?"
    echo "Presione 1 para si"
    echo "Presione cualquier otra tecla para continuar"

    read des; if [ -z $des ];then des=0; fi
    if [ $des == 1 ]; then
        return 1
    else
        return 0
    fi
}

installBash () {
# NOTA: Al modificar esta funcion debes modificar
# la funcion installBash del script de AltoNivel
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
cd $inicio
}




# installBash () {
# 
# sudo cp -a -p -f -v /home/$hsusuario/tron/plugins/bash/bash.bashrc /etc/.bashrc
# sudo chown root:root /etc/.bashrc; sudo chmod 744 /etc/.bashrc
# sudo cp -a -p -f -v /home/$hsusuario/tron/plugins/bash/bash.bashrc /etc/.bash.bashrc
# sudo chown root:root /etc/.bash.bashrc; sudo chmod 744 /etc/.bash.bashrc
# sudo cp -a -p -f -v /home/$hsusuario/tron/plugins/bash/bash.bashrc /root/.bashrc
# sudo chown root:root /root/.bashrc; sudo chmod 744 /root/.bashrc
# 
# cp -a -p -f -v /home/$hsusuario/tron/plugins/bash/bash.bashrc /home/.bashrc
# sudo chown $hsusuario:$hsusuario /home/.bashrc; sudo chmod 744 /home/.bashrc
# cp -a -p -f -v /home/$hsusuario/tron/plugins/bash/bash.bashrc /home/.bash.bashrc
# sudo chown $hsusuario:$hsusuario /home/.bash.bashrc; sudo chmod 744 /home/.bash.bashrc
# cd /home
# source .bashrc
# }
#FIN FUNCIONES *******************

echo "Por favor Ingrese el Nombre del Usuario del sistema externo"
echo "desde donde se hará la mudansa."
read exusuario
echo 'Ingrese la ruta base al sistema externo desde la primera /'
echo 'hasta el nombre de la carpeta montada sin la ultima barra.'
echo 'ejemplo:'
echo '/media/daniel/a728e1a9-d925-4e14-869f-43c422743314'
echo
echo 'Si la ruta es un respaldo de la carpeta HOME'
echo 'ingrese la ruta a esa carpeta sin la barra / final'
echo 'ejemplo: si el respaldo está en: /media/respaldo/home'
echo 'la ruta a ingresar es /media/respaldo'
read v1


echo "PRIMERO DEBEMOS SINCRONIZAR TRON ANTES QUE NADA"
echo "LUEGO INSTALAR BASH"
echo

exrut1="$v1/home/$exusuario/tron"
hsrut1="/home/$hsusuario/"
declare -a ex=("$exrut1")
declare -a hs=("$hsrut1")

for  i in ${!ex[@]}; do
    echo "Copiando: ${ex[$i]} a  ${hs[$i]}:"
    echo
    if [[ -d ${ex[$i]} ]]; then
        cp -a -v -f -p -d -r  "${ex[$i]}" "${hs[$i]}"
    else
        cp -a -p -f -v "${ex[$i]}" "${hs[$i]}"
    fi
    echo
done

cd /home
installBash
echo
echo
echo "Por favor verifica que tron y bash"
echo "se hayan instalado correctamente.."
echo
echo "Asegúrese de Instalar Broot manualmente antes de"
echo "la configuración de broot es automática"

echo "luego, presiona enter para continuar"
read salchichon
echo


#Instalamos losprogramas necesarios:
echo "Instalamos los programas necesarios:" 


instalarbasico
instalarbrew
instalarcode
instalarSass
instalardumpsesionchrome
instalarSpotify
instalarAg
instalarservidorWeb
instalarXnview
instalarDocumentacion
instalarmonolith
instalandoYq
instalandoEasybashgui
instalarRclone 

# desea "Instalar Google Chrome:  debe haberlo descargado y colocado en la carpeta de ejecucion de este script"
# si=$?
    # if [ $si == 1 ]; then
        # apt install -y google-chrome-stable_current_amd64.deb
    # fi


# MUDANZA DE ARCHIVOS Y CONFIGURACIONES

# RUTAS EXTERNAS:
echo
cuentafinal 5 "Procediendo a Mudar Configuraciones"
echo 
echo "Mudando configuraciones"

exrut1="$v1/home/$exusuario/.config/micro"
exrut2="$v1/home/$exusuario/.local/kitty.app"
exrut3="$v1/home/$exusuario/tron/config/sshd_config"
exrut4="$v1/etc/minidlna.conf"
exrut5="$v1/home/$exusuario/.config/vlc/vlcrc"
exrut6="$v1/home/$exusuario/tron/plugins/micro/filemanager"
exrut7="$v1/home/$exusuario/tron/plugins/micro/micro-snippets-plugin"
exrut8="$v1/home/$exusuario/.config/broot/select.toml"
exrut9="$v1/home/$exusuario/.config/broot/select_folder.toml"                          

#RUTAS HOST

hsrut1="/home/$hsusuario/.config/"
hsrut2="/home/$hsusuario/.local/"
hsrut3="/etc/ssh/"
hsrut4="/etc/"
hsrut5="/home/$hsusuario/.config/vlc/vlcrc"
hsrut6="/home/$hsusuario/.config/micro/plug/"
hsrut7="/home/$hsusuario/.config/micro/plug/"
hsrut8="/home/$hsusuario/.config/broot/select.toml"
hsrut9="/home/$hsusuario/.config/broot/select_folder.toml"

declare -a ex=("$exrut1" "$exrut2" "$exrut3" "$exrut4" "$exrut5" "$exrut6" "$exrut7" "$exrut8" "$exrut9")
declare -a hs=("$hsrut1" "$hsrut2" "$hsrut3" "$hsrut4" "$hsrut5" "$hsrut6" "$hsrut7" "$hsrut8" "$hsrut9")

#COPIANDO CARPETAS Y ARCHIVOS EXTERNOS:
# Como los arreglos tienen el mismo tamaño solo itero por el primero
# y reutilizo la variable i en el otro
#OJO LOS DOS VECTORES DEBEN SER DEL MISMO TAMAÑO
# PORQUE SOLO SE ESTA RECORRIENDO UN VECTOR Y RECICLANDO i
for  i in ${!ex[@]}; do
    echo "Copiando: ${ex[$i]} a  ${hs[$i]}:"
    echo
    if [[ -d ${ex[$i]} ]]; then
        cp -a -v -f -p -d -r  "${ex[$i]}" "${hs[$i]}"
    else
        cp -a -p -f -v "${ex[$i]}" "${hs[$i]}"
    fi
    echo
done

# Creando Acceso directo a tron en el navegador de archivos
echo "file:///home/$hsusuario/tron" >> /home/$hsusuario/.config/gtk-3.0/bookmarks
# Cambiando a chrome como determinado para abrir mhtml
echo "application/x-mimearchive=google-chrome.desktop" >> /usr/share/applications/defaults.list
#Instalando Bash

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
sshGit


#Corregir error que no se heredan las bariables de bash ni bashrc
#Instalando Accesos directos de kitty
#mkdir  /home/$hsusuario/.local/bin
#ln -s /home/$hsusuario/.local/kitty.app/bin/kitty /home/$hsusuario/.local/bin/
#cp /home/$hsusuario/.local/kitty.app/share/applications/kitty.desktop #/home/$hsusuario/.local/share/applications/
#cp /home/$hsusuario/.local/kitty.app/share/applications/kitty-open.desktop #/home/$hsusuario/.local/share/applications/
#sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" #/home/$hsusuario/.local/share/applications/kitty*.desktop
#sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" #/home/$hsusuario/.local/share/applications/kitty*.desktop
#sudo ln -v -f $config/minidlna/minidlna.conf /etc/minidlna.conf 

