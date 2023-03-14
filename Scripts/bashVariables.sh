usuario=${SUDO_USER:-${USER}}

#TRON CARPETAS
tron="/home/$usuario/tron"
plugins="$tron/plugins"
sesiones="$tron/sesiones"
funciones="$tron/funciones"
install="$tron/install"
biblioteca="$tron/biblioteca"
zdemas="$tron/zdemas"
respaldosln="$tron/zzRespaldosDeLn"
papelera="$tron/ZPAPELERA"
scripts="$tron/Scripts"
programas="$tron/programas"
sesiones="$tron/sesiones"
logs="$tron/logs"
config="$tron/config"

#SubCarpetas TRON
tronbash="$plugins/bash"
trongedit="$plugins/gedit"
tronscripts="$plugins/admScripts"
practica="$papelera/practica"
appimage="$plugins/AppImage"
musica="$biblioteca/musica"
musicatv="$biblioteca/musicatv"
#Documentos TRON
tronalias="$tronbash/alias.sh"
variables="$tron/plugins/bash/bashVariables.sh"
bashfunciones="/home/daniel/tron/plugins/bash/bashFunciones.sh"
bajonivel="$scripts/BajoNivel.sh"

#GEDIT
geditSis="/usr/share/gedit/plugins/externaltools/tools"
geditSnippets="/usr/share/gedit/plugins/snippets"

#SITIOS DE HOME
descargas="/home/$usuario/Descargas"
escritorio="/home/$usuario/Escritorio"

#IMPORTANTES DEL SISTEMA
servicios="/etc/systemd/system"
fuentes="/etc/apt/sources.list"

#repo es el nombre de la carpeta del repositorio de turno en home
repo=repo2

#DESARROLLO
web="/var/www/html" 
kivyejemplos="/usr/share/kivy-examples"
pycharm="/home/daniel/tron/plugins/pycharm"

#ACCESORIOS
notas="/$tron/zdemas"


#Librerias
libInstallUbuntu="source /home/$usuario/tron/programas/InstallUbuntuChroot/InstallLib.sh/installubuntulib"

#CHULETAS BASH
logica='if [[ $n -ne 0 && $n -ne 1 ]]; then echo "verdadero"; else echo "falso"; fi
'
ifdeunalinea="cat  ~/tron/biblioteca/manAdministracionUbuntu18.04-20.04/bash/achuletas/bash.sh
"
