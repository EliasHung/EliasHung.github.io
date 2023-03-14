El módulo rc es una interfaz de línea de comandos interactiva. Le permite escribir comandos para hacer que VLC haga cosas. Para iniciarlo, ejecuta vlc --intf rc. Esta es la interfaz predeterminada si no hay un entorno GUI disponible. Para comenzar, escriba "ayuda" seguido de enter. A partir de VLC 0.8.0, puede acceder a esta interfaz a través de una red con un cliente telnet utilizando la --rc-host localhost:portopción.



Reproductor multimedia VLC 3.0.11.1 Vetinari (revisión 3.0.11.1-0-g52483f3ca2)
ayuda
[00000000008a8680] lista de reproducción principal: la lista de reproducción está vacía
[0000000000895160] [cli] interfaz lua: escuchando en el host "*console".
Reproductor multimedia VLC 3.0.11.1 Vetinari
Interfaz de línea de comandos inicializada. Escriba `ayuda' para obtener ayuda.
> +----[ Comandos CLI ]
| add XYZ. . . . . . . . . . . . . . . . . . . . agregar XYZ a la lista de reproducción
| poner en cola XYZ. . . . . . . . . . . . . . . . . poner en cola XYZ a la lista de reproducción
| lista de reproducción . . . . . . . . . . . . mostrar elementos actualmente en la lista de reproducción
| cadena de búsqueda]  . . buscar elementos en la lista de reproducción (o restablecer la búsqueda)
| eliminar [X] . . . . . . . . . . . . . . . . eliminar el elemento X en la lista de reproducción
| mover [X][Y] . . . . . . . . . . . . mover el elemento X en la lista de reproducción después de Y
| clave de clasificación. . . . . . . . . . . . . . . . . . . . . ordenar la lista de reproducción
| sd [sd] . . . . . . . . . . . . . mostrar el descubrimiento de servicios o alternar
| jugar . . . . . . . . . . . . . . . . . . . . . . . . . . reproducir corriente
| detener . . . . . . . . . . . . . . . . . . . . . . . . . . detener la corriente
| próximo . . . . . . . . . . . . . . . . . . . . . . siguiente elemento de la lista de reproducción
| anterior . . . . . . . . . . . . . . . . . . . elemento de la lista de reproducción anterior
| ir a, ir a elemento. . . . . . . . . . . . . . . . . ir al elemento en el índice
| repetir [encendido|apagado] . . . . . . . . . . . . . . alternar la repetición de la lista de reproducción
| bucle [encendido|apagado] . . . . . . . . . . . . . . . . alternar bucle de lista de reproducción
| aleatorio [encendido|apagado] . . . . . . . . . . . . . . alternar lista de reproducción aleatoria
| claro  . . . . . . . . . . . . . . . . . . . . . borrar la lista de reproducción
| estado . . . . . . . . . . . . . . . . . . . estado actual de la lista de reproducción
| título [X] . . . . . . . . . . . . . . establecer/obtener título en el elemento actual
| título_n. . . . . . . . . . . . . . . . siguiente título en el elemento actual
| título_p. . . . . . . . . . . . . . título anterior en el elemento actual
| capítulo [X] . . . . . . . . . . . . establecer/obtener capítulo en el elemento actual
| capitulo_n . . . . . . . . . . . . . . próximo capítulo en el elemento actual
| capítulo_p. . . . . . . . . . . . capítulo anterior en el elemento actual
|
| busca X. . . . . . . . . . . buscar en segundos, por ejemplo `buscar 12'
| pausa  . . . . . . . . . . . . . . . . . . . . . . . . alternar pausa
| avance rápido  . . . . . . . . . . . . . . . . . . establecido en la tasa máxima
| rebobinar . . . . . . . . . . . . . . . . . . . . establecido en la tasa mínima
| más rápido . . . . . . . . . . . . . . . . . . reproducción más rápida de la transmisión
| Más lento . . . . . . . . . . . . . . . . . . reproducción más lenta de la transmisión
| normal . . . . . . . . . . . . . . . . . . reproducción normal de la transmisión
| tasa [tasa de reproducción] . . . . . . . . . . establecer la tasa de reproducción al valor
| marco  . . . . . . . . . . . . . . . . . . . . . reproducir cuadro por cuadro
| pantalla completa, f, F [activar|desactivar] . . . . . . . . . . . . alternar pantalla completa
| información [X] . . información sobre el flujo actual (o id especificado)
| estadísticas . . . . . . . . . . . . . . . mostrar información estadística
| consigue tiempo . . . . . . . . . segundos transcurridos desde el comienzo de la transmisión
| está jugando . . . . . . . . . . . . 1 si se reproduce una transmisión, 0 de lo contrario
| obtener_título. . . . . . . . . . . . . el título de la corriente actual
| obtener_longitud. . . . . . . . . . . . la longitud de la corriente actual
|
| volumen [X] . . . . . . . . . . . . . . . . . . establecer/obtener volumen de audio
| volumen [X] . . . . . . . . . . . . . . . subir el volumen del audio X pasos
| bajar [X] . . . . . . . . . . . . . . volumen de audio más bajo X pasos
| acán [X] . . . . . . . . . . . . establecer/obtener el modo de salida de audio estéreo
| una pista [X] . . . . . . . . . . . . . . . . . . . establecer/obtener pista de audio
| pista virtual [X] . . . . . . . . . . . . . . . . . . . establecer/obtener pista de video
| relación [X] . . . . . . . . . . . . . . . establecer/obtener relación de aspecto de video
| vcrop, recortar [X] . . . . . . . . . . . . . . . . configurar/obtener recorte de video
| zoom, zoom [X] . . . . . . . . . . . . . . . . establecer/obtener zoom de video
| vdesentrelazado [X] . . . . . . . . . . . . . configurar/obtener video desentrelazado
| vdeinterlace_mode [X] . . . . . . . establecer/obtener el modo de desentrelazado de video
| instantánea . . . . . . . . . . . . . . . . . . . tomar una instantánea de video
| pista [X] . . . . . . . . . . . . . . . . . establecer/obtener pista de subtítulos
|
| vlm . . . . . . . . . . . . . . . . . . . . . . . . cargar el VLM
| descripción  . . . . . . . . . . . . . . . . . describir este módulo
| ayuda, ? [patrón]  . . . . . . . . . . . . . . . . . un mensaje de ayuda
| longhelp [patrón] . . . . . . . . . . . . . . un mensaje de ayuda más largo
| cerrar . . . . . . . . . . . . . . . . . . . . bloquear el aviso de telnet
| cerrar sesión . . . . . . . . . . . . . . exit (si está en una conexión de socket)
| abandonar . . . . . . . . salir de VLC (o cerrar sesión si está en una conexión de socket)
| cerrar . . . . . . . . . . . . . . . . . . . . . . . apagar VLC
+----[ fin de la ayuda ]


VLC media player 3.0.11.1 Vetinari (revision 3.0.11.1-0-g52483f3ca2)
help
[00000000008a8680] main playlist: playlist is empty
[0000000000895160] [cli] lua interface: Listening on host "*console".
VLC media player 3.0.11.1 Vetinari
Command Line Interface initialized. Type `help' for help.
> +----[ CLI commands ]
| add XYZ  . . . . . . . . . . . . . . . . . . . . add XYZ to playlist
| enqueue XYZ  . . . . . . . . . . . . . . . . . queue XYZ to playlist
| playlist . . . . . . . . . . . . .  show items currently in playlist
| search [string]  . .  search for items in playlist (or reset search)
| delete [X] . . . . . . . . . . . . . . . . delete item X in playlist
| move [X][Y]  . . . . . . . . . . . . move item X in playlist after Y
| sort key . . . . . . . . . . . . . . . . . . . . . sort the playlist
| sd [sd]  . . . . . . . . . . . . . show services discovery or toggle
| play . . . . . . . . . . . . . . . . . . . . . . . . . . play stream
| stop . . . . . . . . . . . . . . . . . . . . . . . . . . stop stream
| next . . . . . . . . . . . . . . . . . . . . . .  next playlist item
| prev . . . . . . . . . . . . . . . . . . . .  previous playlist item
| goto, gotoitem . . . . . . . . . . . . . . . . .  goto item at index
| repeat [on|off]  . . . . . . . . . . . . . .  toggle playlist repeat
| loop [on|off]  . . . . . . . . . . . . . . . .  toggle playlist loop
| random [on|off]  . . . . . . . . . . . . . .  toggle playlist random
| clear  . . . . . . . . . . . . . . . . . . . . .  clear the playlist
| status . . . . . . . . . . . . . . . . . . . current playlist status
| title [X]  . . . . . . . . . . . . . . set/get title in current item
| title_n  . . . . . . . . . . . . . . . .  next title in current item
| title_p  . . . . . . . . . . . . . .  previous title in current item
| chapter [X]  . . . . . . . . . . . . set/get chapter in current item
| chapter_n  . . . . . . . . . . . . . .  next chapter in current item
| chapter_p  . . . . . . . . . . . .  previous chapter in current item
| 
| seek X . . . . . . . . . . . seek in seconds, for instance `seek 12'
| pause  . . . . . . . . . . . . . . . . . . . . . . . .  toggle pause
| fastforward  . . . . . . . . . . . . . . . . . . set to maximum rate
| rewind . . . . . . . . . . . . . . . . . . . . . set to minimum rate
| faster . . . . . . . . . . . . . . . . . .  faster playing of stream
| slower . . . . . . . . . . . . . . . . . .  slower playing of stream
| normal . . . . . . . . . . . . . . . . . .  normal playing of stream
| rate [playback rate] . . . . . . . . . .  set playback rate to value
| frame  . . . . . . . . . . . . . . . . . . . . . play frame by frame
| fullscreen, f, F [on|off]  . . . . . . . . . . . . toggle fullscreen
| info [X] . .  information about the current stream (or specified id)
| stats  . . . . . . . . . . . . . . . .  show statistical information
| get_time . . . . . . . . .  seconds elapsed since stream's beginning
| is_playing . . . . . . . . . . . .  1 if a stream plays, 0 otherwise
| get_title  . . . . . . . . . . . . . the title of the current stream
| get_length . . . . . . . . . . . .  the length of the current stream
| 
| volume [X] . . . . . . . . . . . . . . . . . .  set/get audio volume
| volup [X]  . . . . . . . . . . . . . . .  raise audio volume X steps
| voldown [X]  . . . . . . . . . . . . . .  lower audio volume X steps
| achan [X]  . . . . . . . . . . . .  set/get stereo audio output mode
| atrack [X] . . . . . . . . . . . . . . . . . . . set/get audio track
| vtrack [X] . . . . . . . . . . . . . . . . . . . set/get video track
| vratio [X] . . . . . . . . . . . . . . .  set/get video aspect ratio
| vcrop, crop [X]  . . . . . . . . . . . . . . . .  set/get video crop
| vzoom, zoom [X]  . . . . . . . . . . . . . . . .  set/get video zoom
| vdeinterlace [X] . . . . . . . . . . . . . set/get video deinterlace
| vdeinterlace_mode [X]  . . . . . . .  set/get video deinterlace mode
| snapshot . . . . . . . . . . . . . . . . . . . . take video snapshot
| strack [X] . . . . . . . . . . . . . . . . .  set/get subtitle track
| 
| vlm  . . . . . . . . . . . . . . . . . . . . . . . . .  load the VLM
| description  . . . . . . . . . . . . . . . . .  describe this module
| help, ? [pattern]  . . . . . . . . . . . . . . . . .  a help message
| longhelp [pattern] . . . . . . . . . . . . . . a longer help message
| lock . . . . . . . . . . . . . . . . . . . .  lock the telnet prompt
| logout . . . . . . . . . . . . . .  exit (if in a socket connection)
| quit . . . . . . . .  quit VLC (or logout if in a socket connection)
| shutdown . . . . . . . . . . . . . . . . . . . . . . .  shutdown VLC
+----[ end of help ]


