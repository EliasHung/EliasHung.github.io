#/bin/bash
# Librería para gestionar las sesiones web 
pestanascrom () {
    chrome-session-dump /home/$usuario/.config/google-chrome
}

pestanacromactual ( ){
    chrome-session-dump -active /home/$usuario/.config/google-chrome
}

nombrepestanascrom () {
    chrome-session-dump -printf '%t\n' /home/$usuario/.config/google-chrome
}

borrahistorialcrom () {
    # chrome-session-dump -deleted -history|grep 'chrome-session-dump'
     # Search the history of all (potentially deleted) tabs for a url containing the given expression.
    chrome-session-dump -deleted -history|grep "$1"
    # $1 es la expresion que contiene la pagina a borrar
}

guardarsesionWeb () {
inicio=$PWD
merideam=`date +"%p"`
cd $programas/sesiones/historial
varsesion=sesion_$(date +%d%b%Y%a%Ih%Mm%Ss)-$merideam
echo "vas a ponerle un nombre?, enter para nombre automatico"
read nombre1
if [[ -z $nombre1 ]]; then

    mkdir $varsesion
    cd $varsesion
    echo guardando sesion web ...
    pestanascrom > pestanas.sh
else
    var="${nombre1}_${varsesion}"
    mkdir $var
    cd $var
    echo guardando sesion...
    pestanascrom > pestanas.sh
fi

echo sesion guardada...
cd "$inicio"
}

abrirsesionWeb () {
    aux=$PWD
    echo "ABRIENDO SESION WEB"
    echo
    cd $programas/sesiones/historial
    ls
    echo
    echo "Cuál sesion Web quieres abrir"
    read sesion
    
    cd $sesion
    while IFS="" read -r p || [ -n "$p" ]
    do
      file=$(printf '%s\n' "$p")
      echo '///////////////////////////////////////////'
      echo
      echo abriendo $file
      echo
      xdg-open "$file" > /dev/null 2>&1
      echo '///////////////////////////////////////////'
    done < pestanas.sh
    #for file in ./*.flac; do xdg-open "$file"; done
    cd "$aux"
}






