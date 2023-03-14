#!/bin/bash
usuario=${SUDO_USER:-${USER}}
if [[ ! -f /home/$usuario/tron/plugins/bash/bashVariables.sh || ! -f /home/$usuario/tron/plugins/bash/alias.sh ]]; then
    source /home/tron/plugins/bash/bashVariables.sh
    source /home/tron/plugins/bash/alias.sh
    source /home/tron/Scripts/prog-predet.sh
else
    source /home/$usuario/tron/plugins/bash/bashVariables.sh
    source /home/$usuario/tron/plugins/bash/alias.sh
    source /home/$usuario/tron/Scripts/prog-predet.sh
fi
# FUNCIONES DEBAJO DE ESTO POR FAVOR

com () {
entrada=$1
salida=$2
# gcc $( pkg-config --cflags gtk4 ) -o $salida $entrada $( pkg-config --libs gtk4 )
gcc `pkg-config --cflags gtk4` $entrada `pkg-config --libs gtk4`
}

# FUNCIONES LANZADORAS DE PROGRAMAS DE TRON////////////////////////////////////////
MontarChroot () {
source /home/$usuario/tron/programas/InstallUbuntuChroot/MontarChroot.sh
}

Admon () {
source /home/$usuario/tron/programas/Admon/Admon.sh

}

kaban-on () {
   source  /home/$usuario/tron/programas/GesProgramas/instalar-restaurando-instantanea.sh
}

kaban-off () {
    source /home/daniel/tron/programas/GesProgramas/desintalar-guardando-instantanea.sh
}

PartiClon () {
    source "/home/$usuario/tron/programas/partitionclon/principal.sh" $1
}

adminkaban () {
   source "$programas/GesProgramas/wekan-gantt.sh"
}

# permite navegar hasta un documento con broot
# y abre el archivo para editar con micro
# $1 es la ruta a la carpeta del documento, por defecto es $tron
editFile () {
    if [[ -z $1 ]]; then
        var45="micro  $(br --conf ~/.config/broot/select.toml $tron)"   
         echo "var45 es $var45"
    else
        var46=$1
        var45="micro  $(br --conf ~/.config/broot/select.toml $var46)"
         echo "var45 es $var45"
    fi
       eval $var45

}

# utiliza broot para devolver una ruta
# $1  y ruta_carpeta es la carpeta donde se abrirá inicialmente broot
# USO: micro $(ruta ruta_carpeta) ; mpv $(ruta ruta_carpeta)....

ruta () {
    echo $(br -f  --conf ~/.config/broot/select.toml $1)
}
rutad () {
    echo $(br --sort-by-count -t --conf ~/.config/broot/select_folder.toml $1)
}
# Devuelve la ruta relativa de una documento referencia a
# uno relativo abriendo el navegador para que selecciones los documentos
# a analizar $1 abre broot en  la carpeta referencia, y $2 abre broot en la carpeta relativa
# si no se pasa $1 o $2 se abre broot en /

relativa () {
    realpath --relative-to="$(br --conf ~/.config/broot/select.toml $1)" "$(br --conf ~/.config/broot/select.toml $2)"   
}

vlc () {
    playerctld daemon
    inicio=$PWD
    cd "/home/$usuario/tron/plugins/AppImage"
    ./VLC_media_player-3.0.11.1-x86_64.AppImage --qt-continue=2 $1 
    cd $inicio   
}



nProg () {
    echo "Listando las carpetas"
    echo
    ls $programas
    echo
    echo "¿Dónde lo metemos?, si no existe, se creará la carpeta?"
    read donde
    if [[ ! -d $donde ]]; then
     mkdir $donde
    fi
    if [[ $? != 0 ]]; then
     echo "Error al crear la carpeta"; return -1
    fi
    cd $donde
    echo "nombre de programa con extensión:"
    read nombre
    touch $nombre
    echo dando permiso ejecución
    sudo chmod -v +x $nombre 
    cuentafinal 3 "listo para programar?"
    micro $nombre
}

grepcolor () {
    grep --color=always -R $1
}

lesscolor () {
    less -r $1
}

insensiblemayusculas () {
    shopt -s nocaseglob
}

sensiblemayusculas () {
    shopt -u nocaseglob
}


verdependencias () {
echo "Presione 1 si el paquete es un deb descargado"
echo "Presiona 2 si introducirá el nombre de un paquete"
read num

if [[ $num == 1 ]]; then
	echo introduzca la dirección al paquete
	read direccion
	dpkg-deb -I $direccion
elif [[ $num == 2 ]]; then
	echo "¿Cuál es el nombre del paquete?"
	read paquete
	echo
	echo "las dependencias son:"
	echo
	apt-cache depends $paquete
	echo
fi
}
cp-igualito () {

cp -a -p -f -v $1 $2
    
}
function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        command rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        command rm -f "$cmd_file"
        return "$code"
    fi
}


dondelovi () {
if [[ -z $1 || -z $2 ]]; then
    echo "Uso: dondelovi texto ruta"
    return 1
else
    ag $1 $2
fi
}

chismoso () {
echo "uso: chismoso texto_a_buscar ruta"
echo
if [[ -z $1 || -z $2 ]]; then
    echo "uso: chismoso texto_a_buscar ruta"
    return 1
else

    echo "Busca con ag en $2"
    echo
    dondelovi "$1" "$2"

    echo
    echo '***********************************************'
    echo 'which:'
    which $1
    echo
    echo '***********************************************'

    echo
    echo 'command -V'
    command -V $1
    echo
    echo '***********************************************'
    echo

    #echo 'whereis -b (binarios)'
    #whereis -b $1
    #echo
    #echo '***********************************************'
    #echo
    #echo 'whereis -m (manuales)'
    #whereis -m $1
    #echo
    #echo '***********************************************'
    #echo
    #echo 'whereis -s (sources)'
    #whereis -s $1
    #echo
    echo '***********************************************'
fi
}

funAliased ()
 {

nanoOvisual $tronalias
ordenarfichero $tronalias

}


FunVared ()

{
nanoOvisual "$variables"

	  
}



FunVariables ()

{

#while IFS= read -r line
#do
#  echo "$line"
#done < $tron/plugins/bash/bashVariables.sh
var=$(cat $tron/plugins/bash/bashVariables.sh)

echo "$var" | sort
 

}
# $1=texto existente $2=texto nuevo $3 ruta al documento $4 comando systemctl 
# puede ser start o restart, nada para escribir "texto modificado" luego de la sustitución

leerencolores () {

cat $1 | ccze -A | less -R

}
cambiartextoporotro () {
cuatro=$4
if [[ -z $cuatro ]]; then cuatro="echo texto modificado"; fi
sudo sed -i "s/$1/$2/" $3 || $cuatro
echo
echo "El nuevo contenido de $3 es:":
echo
cat $3

}


grubi () {
ejecutarcomoroot
update-grub
lsblk
echo "En qué dispositivo INSTALAR Grub?"
read dispositivo
grub-install /dev/$dispositivo


}

#muestra que se ha instalado por terminal o linea de comando
queinstale () {
( zcat $( ls -tr /var/log/apt/history.log*.gz ) ; cat /var/log/apt/history.log ) | egrep '^(Start-Date:|Commandline:)' | grep -v aptdaemon | egrep '^Commandline:'

}

#alimenta comandos desde una lista en un documento creo que de horizontal a vertical
#$1 ruta a la lista #2 comando
alimentardesdelista (){

xargs -a <(awk '/^\s*[^#]/' "$1") -r -- $2
if [[ $? != 0 ]]; then echo "No se pudo ejecutar el comando"; fi

}


hayinternet () {
if ! [ "`ping -c 1 google.com 2>/dev/null`" ]; then echo "TRON: $usuario No tenemos Internet"; notify-send "TRON: $usuario No tenemos Internet"; else echo "TRON: $usuario Si hay Internet"; notify-send "TRON: $usuario Si hay Internet" ; fi


}


#elimina las lineas repetidas de un documento
# $1 fichero origen $2 Fichero destino
unicos () {
uniq $1 > $2
}

pausa () {
echo "$1"
echo "Presiona cualquier tecla para continuar..."
read zoncomezon

}



ejecutarcomoroot (){
if (( $EUID != 0 )); then
    echo TRON:
    echo "Mi usuario $usuario por favor ejecute como root"
    echo "y así, venceremos a control maestro"
    sudo su

fi
}

# Recibe una ruta de documento para editar
nanoOvisual ()
{
    echo "presione 1 para micro y 2 para editor visual"
    read frase
    case $frase in
    1)
        editar "$1"
    ;;
    2)
        editar "$1"

    ;;
    esac
}

#recibe el documento fuente y el sitio a copiar destino
cpigualito ()
{
cp -a -p -f -v $1 $2
}



preguntasalir () {
echo "TRON:"
echo $1...?
echo "Nota: $2"
echo "Presiona 1 Para salir"
echo  "Presiona Cualquier otra tecla para continuar"
#para que no de el error se esperaba un operador unario
read frase; if [ -z $frase ];then frase=0; fi
case $frase in
	1)
		
		return 1
	;;
	2)
		return 0
		
    ;;
esac


}

preguntasino () {
echo "TRON:"
echo $1...?
echo "Nota: $2"
echo "Presiona 1 para NO"
echo  "Presiona Cualquier otra tecla para SI"
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
echo "--------------------- $2 --------" 
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
                echo "*********** $2 **********************" 
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

#$1 dispositivo $2 ruta de montaje
montapar () {
    if [[ ! -d $2 ]]; then
        mkdir $2
    fi
    cuentafinal 2 "Montando la Partición en la ruta de montaje..."
    echo la ruta de montaje es $2
    mount /dev/$1 $2
    if [ $? -eq 0 ]; then
        echo "Montaje exitoso"
    else 
        umount -lf $2
        mount /dev/$1 $2
#        exit
    fi

}



montarDiscos ()
{
cd /dev
for dsp in sd*
do
    particion=/dev/$dsp
    destino=/media/$usuario/$dsp
    mkdir $destino
    echo montando $particion en $destino
    mount $particion $destino
done

}
desmontarDiscos () {
cd /media/$usuario
for dsp in *
do
    umount -lf /media/$usuario/$dsp
    rm -d /media/$usuario/$dsp
done


}


infodiscos () {
clear
ejecutarcomoroot
montarDiscos pausa; echo;
lsblk -fml  -o NAME,FSTYPE,LABEL,SIZE,UUID,MOUNTPOINT;
echo; echo después se muestra el espacio ocupado; pausa; echo; echo "Mostrando Espacio"; echo;  df -h; echo; echo seguido se desmontarán las particiones; pausa;
desmontarDiscos; echo; echo Control Maestro: End of Line
}
#Descisión si bifurcarse a una función-rutina o nó
#Recibe la pregunta que describe la bifurcación
#Despues de la bifurcación continua el programa principal
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
# LA opción menos comón es $1 y la mas común $2
dosopciones () {
    echo "Desea $1 ...?"
    echo "Presione 1 para si"
    echo "Presione cualquier otra tecla para $2"
    read des; if [ -z $des ];then des=0; fi
    if [ $des == 1 ]; then
        return 1
    else
        return 0
    fi

}



#Descoprime $1 en $2,
#$1 y $2 son rutas si $2 no existe.
#descomprime en el origen.
#Si se envia la carpeta destino $2 como parametro posisional pero no existe,
#entonces crea la carpeta destino $2.
#Utiliza varios algoritmos y colecciones diferentes de gestores de
#descompresión conocidos, si falla alguno, intenta con otro.
#Crea un proceso de espera y no deja continuar
#el script hasta que finalice de manera fallida o exitosa
# el proceso de descompresión.
descomprimir () {
file=$1
destino=$2
if [[ ! -z $2 ]]; then
    if [[ ! -d $destino ]]; then
        mkdir $destino
    fi

fi

if [[ -z $destino ]]; then
    unar $file
    n=$?

    if [[ $n == 1 ]]; then
            engrampa -h $file
            n=$?
    fi
    
    if [[ $n == 1 ]]; then
            file-roller -h $file
            n=$?
    fi
    
    if [[ $n == 1 ]]; then
        destination=$PWD
        xarchiver --extract-to=$destination $file
        n=$?
    fi
    if [[ $n == 1 ]]; then
        ark --batch -b $file
        n=$?
    fi
else
    unar -o $destino $file
    n=$?
    if [[ $n == 1 ]]; then
        engrampa --extract-to=$destino $file
        n=$?
    fi
    
    if [[ $n == 1 ]]; then
        file-roller --extract-to=$destino $file
        n=$?
    fi
    
    if [[ $n == 1 ]]; then
        xarchiver --extract-to=$destino $file
        n=$?
    fi
    if [[ $n == 1 ]]; then
        ark --batch -b --destination $destino $file
        n=$?
    fi
    
    while [[ $n -ne 0 && $n -ne 1 ]]; do
        sleep 2
        echo "Esperando a que culmine la extracción..."
    done

fi

}





descomprimir1 () {
n=7
# $* son todos los parámetros de entrada
for file in $*;
do
    case $file in 
        *.gz)
            gunzip $file
            n=$?

        ;;
        *.bz2)
            bunzip2 $file
            n=$? 
        ;;
        *.zip)
            unzip -o $file
            n=$?
        ;;
        *.tar)
            tar -zxvf $file
            n=$?
        ;;
        *.tar.xz)
            tar -Jxvf $file
            n=$?
        ;;
        *.tar.bz2)
            tar -Jxvf $file
            n=$?
        ;;
        *)
            pausa
            echo "No era un archivo comprimido, o no estaba registrado"
            n=1
        ;;
    esac

done



while [[ $n -ne 0 && $n -ne 1 ]]; do

    sleep 2
    echo "Esperando a que culmine la extracción..."
done
}


# $1 nombre de archivos y directorios a borrar. 
# se borrará todo lo que aparezca en la búsqueda de locate $1 
borrartodos () {
echo
echo "Los documentos y directorios a borrar son:"
echo
locate $1
echo
echo "Si presiona cualquier tecla para continuar se borrarán"
preguntasalir "Seguro desea borrarlos:"
rm -r -v -d `locate $1`
}

# Pausa el programa y dice: "Presiona cualquier tecla para continuar..."



# $1 Texto que se agregará al final de un documento $2 Ruta al documento
AgregarFinal () {

if [[ -z $1 ]];
then
  echo TRON: uso : AgregarFinal [Texto_A_Agregar] [Ruta_Documento]
  exit
else

echo $1 >> $2
echo TRON: mostrando $2...
echo
echo
cat $2
fi


}

ordenarfichero () {
inicio=$PWD
cd /home/$usuario
archivo=$1
echo $archivo > resp_alias.sh
cat $1 | sort --ignore-case > aux.txt
if [ -f aux.txt ]; then
    cat aux.txt > $archivo
    cat $archivo
    echo Tron:
    echo Mi usuario $usuario
    echo fichero ordenado
    rm -v aux.txt
else
    echo Mi usuario $usuario
    echo Ha ocurrido un error al ordenar el fichero
fi
cd $inicio
}


