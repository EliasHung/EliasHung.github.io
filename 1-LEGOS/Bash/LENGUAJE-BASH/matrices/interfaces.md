# Interfaces:

## [Ejemplos de dialogos sencillos en local](/home/daniel/tron/biblioteca/mkdocs/docs/Tron/1-LEGOS/Bash/interfaces-bash/dialogos.html)



#### EasyBashGUI [Clic auí para documentación](easy.md)



**Fuente:**[https://github.com/BashGui/easybashgui](https://github.com/BashGui/easybashgui)

### Menú Cli con Dialog:

``` bash

#!/bin/bash

items=(1 "Item 1"
       2 "Item 2")

while choice=$(dialog --title "$TITLE" \
                 --menu "Please select" 10 40 3 "${items[@]}" \
                 2>&1 >/dev/tty)
    do
    case $choice in
        1) ;; # some action on 1
        2) ;; # some action on 2
        *) ;; # some action on other
    esac
done
clear # clear after user pressed Cancel

```
### Menú gráfico con zenity

``` bash
#!/bin/bash

items=("Item 1" "Item 2" "Item 3")

while item=$(zenity --title="$title" --text="$prompt" --list \
               --column="Options" "${items[@]}")
do
    case "$item" in
        "${items[0]}") echo "Selected $item, item #1";;
        "${items[1]}") echo "Selected $item, item #2";;
        "${items[2]}") echo "Selected $item, item #3";;
        *) echo "Ooops! Invalid option.";;
    esac
done
```
### Whiptail: 
**Fuente:**[https://linux.die.net/man/1/whiptail](https://linux.die.net/man/1/whiptail)
**Fuente:**[https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail](https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail)



#### Filebrowser con vectores y barras de desplazamiento navegador de archivos.
**Fuente:** [https://github.com/pageauc/FileBrowser](https://github.com/pageauc/FileBrowser)
``` bash

#!/bin/bash

: '
                   filebrowse.sh written by Claude Pageau

This is a whiptail file browser demo that allows navigating through a directory
structure and select a specified file type per filext variable.
It Returns a filename path if selected.  Esc key exits.
This sample code can be used in a script menu to perform an operation that
requires selecting a file.

'

startdir="/home/pi"
filext='jpg'
menutitle="$filext File Selection Menu"

#------------------------------------------------------------------------------
function Filebrowser()
{
# first parameter is Menu Title
# second parameter is optional dir path to starting folder
# otherwise current folder is selected

    if [ -z $2 ] ; then
        dir_list=$(ls -lhp  | awk -F ' ' ' { print $9 " " $5 } ')
    else
        cd "$2"
        dir_list=$(ls -lhp  | awk -F ' ' ' { print $9 " " $5 } ')
    fi

    curdir=$(pwd)
    if [ "$curdir" == "/" ] ; then  # Check if you are at root folder
        selection=$(whiptail --title "$1" \
                              --menu "PgUp/PgDn/Arrow Enter Selects File/Folder\nor Tab Key\n$curdir" 0 0 0 \
                              --cancel-button Cancel \
                              --ok-button Select $dir_list 3>&1 1>&2 2>&3)
    else   # Not Root Dir so show ../ BACK Selection in Menu
        selection=$(whiptail --title "$1" \
                              --menu "PgUp/PgDn/Arrow Enter Selects File/Folder\nor Tab Key\n$curdir" 0 0 0 \
                              --cancel-button Cancel \
                              --ok-button Select ../ BACK $dir_list 3>&1 1>&2 2>&3)
    fi

    RET=$?
    if [ $RET -eq 1 ]; then  # Check if User Selected Cancel
       return 1
    elif [ $RET -eq 0 ]; then
       if [[ -d "$selection" ]]; then  # Check if Directory Selected
          Filebrowser "$1" "$selection"
       elif [[ -f "$selection" ]]; then  # Check if File Selected
          if [[ $selection == *$filext ]]; then   # Check if selected File has .jpg extension
            if (whiptail --title "Confirm Selection" --yesno "DirPath : $curdir\nFileName: $selection" 0 0 \
                         --yes-button "Confirm" \
                         --no-button "Retry"); then
                filename="$selection"
                filepath="$curdir"    # Return full filepath  and filename as selection variables
            else
                Filebrowser "$1" "$curdir"
            fi
          else   # Not correct extension so Inform User and restart
             whiptail --title "ERROR: File Must have $filext Extension" \
                      --msgbox "$selection\nYou Must Select a $filext file" 0 0
             Filebrowser "$1" "$curdir"
          fi
       else
          # Could not detect a file or folder so Try Again
          whiptail --title "ERROR: Selection Error" \
                   --msgbox "Error Changing to Path $selection" 0 0
          Filebrowser "$1" "$curdir"
       fi
    fi
}


Filebrowser "$menutitle" "$startdir"

exitstatus=$?
if [ $exitstatus -eq 0 ]; then
    if [ "$selection" == "" ]; then
        echo "User Pressed Esc with No File Selection"
    else
        whiptail --title "File was selected" --msgbox " \

        File Selected information

        Filename : $filename
        Directory: $filepath

        \
        " 0 0 0
        echo ""
        echo "---- $0 variable output values -----"
        echo ""
        echo '$filename = '$filename
        echo '$filepath = '$filepath
        echo ""
        echo "You can combine variables per"
        echo 'echo $filepath/$filename'
        echo "result is"
        echo "$filepath/$filename"
        echo ""
        echo "Variables can be used in command execution"
    fi
else
    echo "User Pressed Cancel. with No File Selected."
fi
echo ""
echo "This is demo code that can be used in your own projects"


```
#### Lista de Radios Con vectores: 
**Fuente** : [https://saveriomiroddi.github.io/Shell-scripting-adventures](https://saveriomiroddi.github.io/Shell-scripting-adventures)

``` bash
declare -A v_usb_storage_devices=([/dev/sdb]="My USB Key" [/dev/sdc]="My external HDD")

entry_options=()
entries_count=${#v_usb_storage_devices[@]}
message=$'Choose an external device. THE DEVICE WILL BE COMPLETELY ERASED.\n\nAvailable (USB) devices:\n\n'

for dev in "${!v_usb_storage_devices[@]}"; do
   entry_options+=("$dev")
   entry_options+=("${v_usb_storage_devices[$dev]}")
   entry_options+=("OFF")
done

v_sdcard_device=$(whiptail --radiolist --title "Device choice" "$message" 20 78 $entries_count -- "${entry_options[@]}" 3>&1 1>&2 2>&3)

echo "$v_sdcard_device" # Y dicen que la primera fue elegida
/dev/sdb

```
Usamos --en caso de que cualquiera de los entry_optionsiniciados con -; si no hacemos esto, whiptailpensará que es un parámetro de línea de comandos.

Tenga en cuenta que debido a que las matrices asociativas no están ordenadas, es posible que el orden de visualización no refleje el orden de inserción de la tupla. Para solucionar esto, uno puede ordenar manualmente las claves (esto está fuera del alcance, a menos que los lectores lo soliciten).

El formato general de los parámetros de este widget es:
``` bash
whiptail --radiolist [--title mytitle] <body_message_header> <width> <height> <entries_count> -- <entry_1_key> <entry_1_description> <entry_1_state> [<other entry params>...]
```
Para almacenar los parámetros de definición de la lista (clave, descripción, estado), usamos una matriz:

ciclamos las definiciones matriz asociativa ( for dev in "${!v_usb_storage_devices[@]}")
para cada ciclo, agregamos a la $entry_optionsmatriz la clave (ruta del dispositivo), la descripción y el estado predeterminado ( OFFpara todos, en este caso).

### Otros:

**Base de datos:**[https://github.com/theJaxon/bash_dbengine/blob/master/db_operations.sh](https://github.com/theJaxon/bash_dbengine/blob/master/db_operations.sh)

**Buscar Editar:** Busca un texto en un conjunto de archivos y permite seleccionarlo visualmente entre los resultados y editarlo en $EDITOR **fuente**[https://github.com/StefanMajonez/search-edit](https://github.com/StefanMajonez/search-edit)



