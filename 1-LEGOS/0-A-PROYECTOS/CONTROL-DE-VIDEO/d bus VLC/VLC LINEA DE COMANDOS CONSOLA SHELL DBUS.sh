nooooooooooo

SOLUCION playerctl
https://github.com/altdesktop/playerctl

PARA QUE INICIE y CONTINUE LA PLAY DEONDE LA DEJO
     --qt-continue={0 (Never), 1 (Ask), 2 (Always)} 
al iniciarlo

para hacerlo permanente
modificar: 

micro ~/.config/vlc/vlcrc

y colocar:

# Continue playback? (integer)
qt-continue=2

#2 es para siempre 0 never y 1 preguntar


otros manuales playerctl
https://man.archlinux.org/man/community/playerctl/playerctl.1.en
https://manpages.ubuntu.com/manpages/focal/man1/playerctl.1.html

API
https://dubstepdish.com/playerctl/api-index-full.html
https://lazka.github.io/pgi-docs/Playerctl-2.0/index.html

PARA USAR CON PYTHON
https://github.com/altdesktop/playerctl/tree/master/examples

HAY UN
mpv --save-position-on-quit
para VLC

TIENE TODO LO QUE NECESITO



VER TAMBIEN display 0
Reproduce un video con VLC en X11 desde una terminal remota
https://stackoverflow.com/questions/9636268/play-a-video-with-vlc-in-x11-from-remote-terminal




PRUEBA ESTE PRIMERO CON JAVASCRIPT



https://github.com/alexandrucancescu/node-vlc-client



control http 
https://wiki.videolan.org/VLC_HTTP_requests/


vlc dbus
obtener el tiempo de repro con python
https://www.geeksforgeeks.org/vlc-module-in-python-an-introduction/
CODIGO FUENTE vlc.py 
https://git.videolan.org/?p=vlc/bindings/python.git;a=blob;f=generated/3.0/vlc.py;h=f501b5e259196f722ff8df0340a2b3ad34ebf0b7;hb=HEAD

documentacion de cbindins phython vlc https://www.olivieraubert.net/vlc/python-ctypes/doc/
EJEMPLOS DE USO
 https://stackoverflow.com/questions/56103533/how-can-i-control-vlc-media-player-through-a-python-scripte


if __name__ == '__main__'
https://wiki.videolan.org/Python_bindings/
https://www.javatpoint.com/python-vlc-module

Activar Dbus (solo si no está activado)

Esto funciona bien:
$ vlc --control dbus

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop

dbus-send --print-reply --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next

dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Seek int64:"200000000"

dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

# volumen desde 0.0 a 1.0
dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Volume variant:double:0.5




















Un script bash que usa gdbus para llamar a métodos de interfaz vlc dbus y obtener/establecer propiedades.
vlc_dbus.sh
#! /bin/bash

# bash script usando gdbus para llamar a métodos de interfaz vlc dbus y obtener/establecer propiedades

iface= ' org.mpris.MediaPlayer2 '
dest= " $iface .vlc "

obj= ' /org/mpris/MediaPlayer2 '

i_prop= ' org.freedesktop.DBus.Properties '
get_prop= " $i_prop .Obtener "
set_prop= " $i_prop .Conjunto "

i_introspect= ' org.freedesktop.DBus.Introspectable.Introspect '

common= " --session --dest $dest --object-path $obj "


# comprobar comando
si [[ !  $1 ]]
entonces
	options=(urischemes mimetypes estado agregar volumen salir pausa reproducir id instancias list_services)

	echo  ' elija entre las siguientes opciones: '
	para  o  en  ${opciones[@]}
	hacer
		echo -n -e $o ' \t '
	hecho
	eco
	salida 0
fi


# funciones
analizar_lista () {
	leer lista
	echo  $lista  | grep -Po " '\w.*?' "  |   tr -d " ' "  | clasificar
}	

lista_servicios () {
	gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/DBus --method org.freedesktop.DBus.ListNames | parse_list
}

comprobar_arg () {
	si [[ !  $1 ]]
	entonces 
		eco  $2
		salida 1
	fi
}

parse_num () {
	leer valor
 	echo  $valor  | grep -Po " (\d+.)?\d+ "
}

analizar_str () {
	leer valor
	echo  $valor  | grep -Po " '.*' "  | tr -d " ' "
}

redondo () {
	leer valor
	printf  " %.2f\n "  $( echo " scale=2; $val "  | bc )
}


# manejar comando
caso  $1  en
	urischemes)		 # obtener esquemas uri compatibles
		llamada gdbus $common --method $get_prop  " $iface "  " SupportedUriSchemes "  | parse_list
		;;
	mimetypes)			 # obtener tipos mime compatibles
		llamada gdbus $common --method $get_prop  " $iface "  " SupportedMimeTypes "  | parse_list
		;;
	estado)				 # obtener el estado del jugador
		llamada gdbus $common --method $get_prop  " $iface .Player "  " PlaybackStatus "  | parse_str
		;;
	agregar)				 # agregar pista a la lista de reproducción
		check_arg " $2 "  ' proporcione la ruta del archivo/directorio '
		no_track= " $obj /TrackList/NoTrack "
		llamada gdbus $common --method $iface .TrackList.AddTrack " file:// $2 "  $no_track  true
		;;
	volumen)				 # establecer / obtener volumen
		si [[ $2 ]]
		entonces
			llamada gdbus $común --método $set_prop  " $iface .Player "  " Volumen "   " <doble $2 > "
		demás
			llamada gdbus $common --method $get_prop  " $iface .Player "  " Volumen "  | parse_num | redondo
		fi
		;;
	salir)				 # salir de vlc
		llamada gdbus $común --método $iface .Salir
		;;
	pausa)				 # pausa reproducción
		llamada gdbus $común --método $iface .Player.Pause
		;;
	reproducir)				 # iniciar la reproducción
		llamada gdbus $común --método $iface .Player.Play
		;;
	id)					 # propiedad: Identidad
		llamada gdbus $común --método $get_prop  " $iface "  " Identidad "  | parse_str
		;;
	instancias)			 # enumerar los nombres de dbus de todas las instancias de vlc en ejecución
		lista_servicios | grep vlc.instancia
		;;
	list_services)		 # obtener una lista de todos los servicios de dbus
		lista_servicios		
		;;
esac

salida 0










A bash script using gdbus to call vlc dbus interface methods and get / set properties.
vlc_dbus.sh
#!/bin/bash

# bash script using gdbus to call vlc dbus interface methods and get / set properties

iface='org.mpris.MediaPlayer2'
dest="$iface.vlc"

obj='/org/mpris/MediaPlayer2'

i_prop='org.freedesktop.DBus.Properties'
get_prop="$i_prop.Get"
set_prop="$i_prop.Set"

i_introspect='org.freedesktop.DBus.Introspectable.Introspect'

common="--session --dest $dest --object-path $obj"


# check command
if [[ ! $1 ]]
then
	options=(urischemes mimetypes status add volume quit pause play id instances list_services)

	echo 'please choose from the following options:'
	for o in ${options[@]}
	do
		echo -n -e $o'\t'
	done
	echo
	exit 0
fi


# functions
parse_list() {
	read list
	echo $list | grep -Po "'\w.*?'" |  tr -d "'" | sort
}	

list_services() {
	gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/DBus --method org.freedesktop.DBus.ListNames | parse_list
}

check_arg() {
	if [[ ! $1 ]]
	then 
		echo $2
		exit 1
	fi
}

parse_num() {
	read val
 	echo $val | grep -Po "(\d+.)?\d+"
}

parse_str() {
	read val
	echo $val | grep -Po "'.*'" | tr -d "'"
}

round() {
	read val
	printf "%.2f\n" $(echo "scale=2;$val" | bc)
}


# handle command
case $1 in
	urischemes)		# get supported uri schemes
		gdbus call $common --method $get_prop "$iface" "SupportedUriSchemes" | parse_list
		;;
	mimetypes)			# get supported mime types
		gdbus call $common --method $get_prop "$iface" "SupportedMimeTypes" | parse_list
		;;
	status)				# get player status
		gdbus call $common --method $get_prop "$iface.Player" "PlaybackStatus" | parse_str
		;;
	add)				# add track to playlist
		check_arg "$2" 'please provide file/dir path'
		no_track="$obj/TrackList/NoTrack"
		gdbus call $common --method $iface.TrackList.AddTrack "file://$2" $no_track true
		;;
	volume)				# set / get volume
		if [[ $2 ]]
		then
			gdbus call $common --method $set_prop "$iface.Player" "Volume"  "<double $2>"
		else
			gdbus call $common --method $get_prop "$iface.Player" "Volume" | parse_num | round
		fi
		;;
	quit)				# quit vlc
		gdbus call $common --method $iface.Quit
		;;
	pause)				# pause playback
		gdbus call $common --method $iface.Player.Pause
		;;
	play)				# start playback
		gdbus call $common --method $iface.Player.Play
		;;
	id)					# property: Identity
		gdbus call $common --method $get_prop "$iface" "Identity" | parse_str
		;;
	instances)			# list dbus names of all running vlc instances
		list_services | grep vlc.instance
		;;
	list_services)		# get a list of all dbus services
		list_services		
		;;
esac

exit 0
@EliasHung





///////////////////////////////////////////////////////







#! /bin/sh
nombre= " $1 "
cambio
RUTAS = " org.mpris.MediaPlayer2. $nombre /org/mpris/MediaPlayer2 "
DBUS_SEND= " dbus-send --type=method_call --dest= $PATHS "
RC= " $ DBUS_SENDorg.mpris.MediaPlayer2.Player "
si [ " $ @ "  =  " anterior " ] ;  entonces
    $RC .Anterior
elif [ " $ @ "  =  " detener " ] ;  entonces
    $RC .Pausa
elif [ " $ @ "  =  " alternar " ] ;  entonces
    $RC .ReproducirPausa
elif [ " $ @ "  =  " siguiente " ] ;  entonces
    $RC .Siguiente
elif [ " $ @ "  =  " al azar " ] ;  entonces
    actual= $( mdbus2 $ RUTAS org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player Shuffle )
    if [ " $actual "  =  " (verdadero) " ] ;  entonces
        otro=falso
    demás
        otro = verdadero
    fi
    $DBUS_SEND org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Shuffle variant:boolean: $other
demás
    echo  " Comando no encontrado para el jugador $nombre : $@ "  1>&2
    salida 1
fi
@nmrugg
nmrugg comentado el 7 de julio de 2015
Nota: Inserte export DISPLAY=:0en la línea 2 para que esto funcione a través de ssh.



player-control
#!/bin/sh
name="$1"
shift
PATHS="org.mpris.MediaPlayer2.$name /org/mpris/MediaPlayer2"
DBUS_SEND="dbus-send --type=method_call --dest=$PATHS"
RC="$DBUS_SEND org.mpris.MediaPlayer2.Player"
if [ "$@" = "prev" ]; then
    $RC.Previous
elif [ "$@" = "stop" ]; then
    $RC.Pause
elif [ "$@" = "toggle" ]; then
    $RC.PlayPause
elif [ "$@" = "next" ]; then
    $RC.Next
elif [ "$@" = "random" ]; then
    current=$(mdbus2 $PATHS org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player Shuffle)
    if [ "$current" = "( true)" ]; then
        other=false
    else
        other=true
    fi
    $DBUS_SEND org.freedesktop.DBus.Properties.Set string:org.mpris.MediaPlayer2.Player string:Shuffle variant:boolean:$other
else
    echo "Command not found for player $name: $@" 1>&2
    exit 1
fi
@nmrugg
nmrugg commented on Jul 7, 2015
Note: Insert export DISPLAY=:0 at line 2 to make this work via ssh.




********************************************




#!/usr/bin/env python

 sistema de importación
desde  el entorno de  importación del  sistema operativo

si  'DISPLAY'  no está  en el  entorno :
    salir ( 0 )

nombre  =  "caja de ritmos"
si  len ( sys . argv ) >  1 :
    nombre  =  sist . arg [ 1 ]

importar  dbus

autobús  =  dbus . Bus de sesión ()

prueba :
    proxy  =  autobús . get_object ( "org.mpris.MediaPlayer2.%s"  %  nombre , "/org/mpris/MediaPlayer2" )
    dispositivo_prop  =  dbus . Interfaz ( proxy , "org.freedesktop.DBus.Properties" )

    prop  =  dispositivo_prop . Obtener ( "org.mpris.MediaPlayer2.Player" , "Metadatos" )

    estado  =  prop_dispositivo . Obtener ( "org.mpris.MediaPlayer2.Player" , "Estado de reproducción" )
excepto  dbus . excepciones _ Excepción DBus :
    # Probablemente no se esté ejecutando.
    salir ( 0 )

si  estado  ==  "Reproduciendo" :
    imprimir ( prop . get ( "xesam:artista" )[ 0 ] +  " - "  +  prop . get ( "xesam:título" )). codificar ( 'utf-8' )
más :
    imprimir  "No jugando".




Get status from player implementing MPRIS D-Bus Specification v2.2
mediaplayer2-listening
#!/usr/bin/env python

import sys
from os import environ

if 'DISPLAY' not in environ:
    exit(0)

name = "rhythmbox"
if len(sys.argv) > 1:
    name = sys.argv[1]

import dbus

bus = dbus.SessionBus()

try:
    proxy = bus.get_object("org.mpris.MediaPlayer2.%s" % name, "/org/mpris/MediaPlayer2")
    device_prop = dbus.Interface(proxy, "org.freedesktop.DBus.Properties")

    prop = device_prop.Get("org.mpris.MediaPlayer2.Player", "Metadata")

    status = device_prop.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus")
except dbus.exceptions.DBusException:
    # Probably not running.
    exit(0)

if status == "Playing":
    print (prop.get("xesam:artist")[0] + " - " + prop.get("xesam:title")).encode('utf-8')
else:
    print "Not playing."



--------------------------------------------------------




