#/bin/bash
# librería para que controlar las sesiones de  clases y cursos.


#registra los procesos abiertos en una variable local en memoria
# $1 recibe el nombre del proceso y $2 el número de proceso


registraProceso () {
    if [[ -z $NOMBRE_PID ]]; then
        export NOMBRE_PID=""
    fi 
    if [[ -z $NUMERO_PID ]]; then
        export NUMERO_PID=""
    fi 
    NOMBRE_PID+=" "$1
    NUMERO_PID+=" "$2
    echo 
    echo "Listando los números de Procesos:" 
    for i in $NUMERO_PID; do echo $i; done
    echo
    echo "Listando los nombres de los procesos:"
    for i in $NOMBRE_PID; do echo $i; done
    echo
    echo "Proceso  nuevo: $NOMBRE_PID número: $NUMERO_PID." 
    echo
    echo "***************************"
}

# $1 recibe la forma de cierre [nombre/numero/todos]
# $2 recibe el nombre_proceso ó num_proceso 

cierraProceso () { 
if [[ $1 == "nombre" ]]; then
# No se puede iterar por posición en una variable
# Así que la convertimos en vector
read -ra numero_pid <<<"$NUMERO_PID"
    pos=0
    for j in $NOMBRE_PID; do
           
        if [[ $j == $2 ]]; then
            echo pos es $pos
            echo  pid es:"${numero_pid[$pos]}"
            kill "${numero_pid[$pos]}"
            echo "Muerto"
            break
        else
            pos=$((pos+1))
            
        fi
    done    
fi
    
 if [[ $1 == "numero" ]]; then
    kill $2
 fi 
 if [[ $1 == "todos" ]]; then
    if [[ -z $NOMBRE_PID ]] && [[ -z $NUMERO_PID ]]; then
        echo " No existen variables, nada que hacer."
        return 1
    fi
    echo
    echo "Borrando:"
    echo
    for j in $NUMERO_PID; do  echo $j; done
    for i in $NOMBRE_PID; do echo $i; done
    unset NOMBRE_PID
    unset NUMERO_PID      
 fi
     
}


 # Si $1=1 el segundo parametro es una matriz de tipo de app (video, audio....).
 # Si $1=2 el segundo parámetro es una matriz de appmime "inode/directory"
 # para carpetas,  "application/x-mimearchive" para archivos mhtml etc.
 # con shift se borra el primer parámetro pasado y quedan los demás, es
 # decir el vector que estaba en $2 queda en $1.

abrirDocu () {
    # Validacion
    USAGE='Uso: abrirDocu modo [app/appmime] vector \n \n Ejemplo: abrirDocu "app" "${app[@]}"'
    if [ "$#" == "0" ]; then
        echo
    	echo -e "$USAGE"
    	return 1
    fi
    # Fin validación

    playerctld daemon
    if [[ $1 == "app" ]]; then
    # shift corre los paramtros posicionales a la izq
    #eliminando el primero
    shift
    # al borrar el primer parámetro ajustamos posición del vector (posvector) a $1
    posvector=$1
    # Mientras existan parámetros posicionales hacer
    while (( "$#" )); do 
        for file in ./*
        do
            # echo posvector es $posvector
            # echo '$# es'$#
            # echo '$1 es'$1
            # echo '$file es'$file
            # return 1
            # echo 'cosararaes:' $(xdg-mime query filetype "$file" | awk -F "/" '{print $1}')
            # echo
             
           if [[ $(xdg-mime query filetype "$file" | awk -F "/" '{print $1}') == "$posvector" ]]; then
           # echo verdad..
    
              if [[ "$posvector" == "video" ]]; then
                # acá se elige el programa de apertura
                # para el tipo de mime (video audio etc)
                
                vlc "$PWD${file#.}" > /dev/null 2>&1 & 
                interfazMarcadores "$PWD${file#.}" 
                
              else
                xdg-open "$file"
                
              fi
           fi
        
        done
        # Corro parámetro posicional a la izq ($1 se borra y $2 es el nuevo $1) 
        shift
        # nueva posición del vector
        posvector=$1    
    done
fi
# Recuerda que appmime son los dos nombres:
# del typemime, ejemplo "video/mp4" y app es solo el primer nombredel typemime antes de /  ejemplo "video"
if [[ $1 == "appmime" ]]; then
shift
posvector=$1
    # mientras haya parámetros
    while (( "$#" )); do 
        for file in ./*
        do
           if [[ $(xdg-mime query filetype "$file") == "$posvector" ]]; then
            xdg-open "$file"  > /dev/null 2>&1             
           
           fi
        
        done
        shift
        posvector=$1    
    done
fi
sleep 1
playerctl pause
}

# Esta función sirve para teclear un modo:
# nombre_curso y más nada, envíará el modo [app/appmime] y el vector de elementos a abrir a abrirdocu()


abrirdocuArray() {
    inicio=$PWD
    cd $cursos
    source $programas/interfaces/libwhiptail.sh
    whipmensaje 'Apertura de Curso' 'En la pantalla siguiente elija la carpeta de su curso' 
    carpeta_curso=$(rutad)
    cd $carpeta_curso
    whipmensaje 'Elección de Clase' 'En la pantalla siguiente elija la clase a aperturar' 
    carpeta_clase=$(rutad)
    cd $carpeta_clase
    echo "estoy en $PWD"
    echo "la variable de curso es $carpeta_curso"
    directorio=$(basename "$carpeta_curso")
    
    case "$directorio" in
    
      "CursoHarvardWeb")
           
          source $tron/data/binbash/mime/claseHardvard.sh
          abrirDocu "app" "${app[@]}"
          abrirDocu "appmime" "${appmime[@]}"
      ;;
      "caso2")
        echo
      ;;
         *)
        echo
      ;;
    esac
    # cd $inicio
 
}


# La carpeta raiz del script debe ser  la carpeta
#  donde están los videos que se van a marcar
# (hay que hacer cd a la carpeta), y ejecutar allí.

# La base de datos está dentro  del directorio
# .marcadores, y se llama videos.yaml .

# Puede almacenar todos los marcadores (nombre y tiempo) de todos los videos de la carpeta
# ( "o de una carpeta de clase...").

# TODO: Usar la función de yaml ordenar para cuando se
# vaya a listar al usuario los marcadores para ir
# al mismo; lo haga de forma oredenada por orden
# alfabético vel el pendiente del escritorio
# ejemplo de entrada video.mp4 nombre_mar1 4222554551

# Comentarios: este script también funciona para crear bases de datos de configuraciones justo cuando se crea el primer registro.
AnadirMarcador () {
    folder=$PWD
    if [[ ! -d .marcadores ]]; then
        mkdir .marcadores
    fi
    nombreVideo=$1
    nombreMarcador=$2
    tiempoMarcador=$3
    # si no existe o esta vacio: marcadores.yaml,
    # crea marcadores.yaml
    cd .marcadores
    #if [[ ! -s marcadoresVideo.yaml ]]; then
        # Utilización de una plantilla para iniciar la base de datos
        cd "$programas/plantillas"
        source marcaVideo.sh $nombreVideo $nombreMarcador $tiempoMarcador 1>> $folder/.marcadores/marcadoresVideo.yaml
 #   fi
    cd $folder
}

interfazMarcadores () {
nombrevideo=$1
if [[ -z $1 ]]; then
    var87=$(playerctl metadata --format '{{ xesam:url }}' |  awk -F "file:///" '{print $2}')
    nombrevideo="/$var87"
fi
abierto=true
while [[ "$abierto" == "true" ]]; do
    echo "Presione 1 para marcar el Video"
    echo "Presione 2 para ir a Marcador"
    echo "Presione 3 para Salir"
    echo
    read respuesta
    case $respuesta  in
    "1")
        pos=$(playerctl position)
        echo
        echo "Ingrese El Nombre de Marcador"
        read nomar
        AnadirMarcador $nombrevideo $nomar $pos  
        clear
        echo
        echo "Marcador $nombrevideo $nomar $pos enviado"
        pausa      
        clear
      ;;

     "2")
                mousepad
      ;;

     "3")
                return 0
      ;;

    esac

done

}

renovacionDeInterfazDeLista() {   
# comentamos sin comentarios
if [[ ! -z $x ]]; then
    
    while [[ "true" == "true" ]]; do
        inotifywait -q -e close_write ~/pruebas/sincro |
        while read -r filename event; do

             selection=$(whiptail --title "ttitulo" \
             --menu "Use: PgUp/PgDn/Flechas, para moverse.\nEnter, /Seleciona Archivo/Carpeta o la tecla de Tabulación para cambiar de campos.\n $curdir" 0 0 0 \
             --cancel-button Cancelar \
             --ok-button Seleccionar ../ BACK $MARCADORES 3>&1 1>&2 2>&3)
        done  
    done
fi

}

# FIN FIN FIN *************** IDEAS ************
# FIN FIN FIN *************** IDEAS ************
# FIN FIN FIN *************** IDEAS ************
# FIN FIN FIN *************** IDEAS ************
# FIN FIN FIN *************** IDEAS ************
# FIN FIN FIN *************** IDEAS ************


# TODO ALGÚN DÍA PENDIENTE Base de datos de typemime 
# $1 es el nombre del yaml si no existe lo crea 
insertarMime () {
    folder=$PWD
    cd ../../../data/yaml/mime
    if [[ ! -f $1 ]]; then
        mkdir $1
    fi
    nombreVideo=$1
    nombreMarcador=$2
    tiempoMarcador=$3
    # si no existe o esta vacio: marcadores.yaml,
    # crea marcadores.yaml
    if [[ ! -s marcadoresVideo.yaml ]]; then
        # Utilización de una plantilla para iniciar la base de datos
        cd "$programas/plantillas"
        source marcaVideo.sh $nombreVideo $nombreMarcador $tiempoMarcador 1> $folder/.marcadores/marcadoresVideo.yaml
    fi
    cd $folder
}




