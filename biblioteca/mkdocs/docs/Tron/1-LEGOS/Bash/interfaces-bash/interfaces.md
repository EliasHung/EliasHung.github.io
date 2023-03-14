# Interfaces:

## GTK 3 con PyGObject
**Fuente:** [Referencia de la API](http://lazka.github.io/pgi-docs/)

**Fuente:** [PyOBject sirve para todas las plataformas...](https://pygobject.readthedocs.io/en/latest/getting_started.html#ubuntu-getting-started)

**Fuente:** [Documentacion](https://www.gtk.org/docs/language-bindings/python/)

**Fuente:** [Tutorial - Ver el Ejemplo extendido](https://python-gtk-3-tutorial.readthedocs.io/en/latest/introduction.html)


En esta parte es donde se puede enviar la salida de la interfaz.py a la salida estándar:

``` python

    def on_button_clicked(self, widget):
        print("Hello World")
``` 


## gtkdialog
**fuente paquete** [https://mxrepo.com/MX15packages.html](https://mxrepo.com/MX15packages.html)
> también disponible en $plugins/comprimidosO.deb

**Manual local gtkdialog:** [gtkdialog.md](gtkdialog.md)  
>***Tiene una entrada en sesiones web con manuales***


## Zenity:
***Fuente manual:*** [https://help.gnome.org/users/zenity/stable/index.html.en](https://help.gnome.org/users/zenity/stable/index.html.en)
### Importante:

> ***Claves de acceso***
>Una tecla de acceso es una tecla que le permite realizar una acción desde el teclado en lugar de usar el mouse para elegir un comando de un menú o cuadro de diálogo. Cada tecla de acceso se identifica con una letra subrayada en una opción de menú o cuadro de diálogo.

>Algunos cuadros de diálogo de Zenity admiten el uso de claves de acceso. Para especificar el carácter que se usará como clave de acceso, coloque un guión bajo antes de ese carácter en el texto del cuadro de diálogo. El siguiente ejemplo muestra cómo especificar la letra 'C' como clave de acceso:

``` bash
"_Escoge un nombre".

```

### Formulario con lista:

``` bash
zenity --forms --add-list="interfaces" --list-values="eth0|eth1|wlan0"

``` 

### Capturar la salida:

#### Capturar salida 1

``` bash
OUTPUT=$(zenity --forms --title="Add Friend" --text="Enter Multicast address" --separator="," --add-entry="IP address" --add-entry="PORT")
accepted=$?
if ((accepted != 0)); then
    echo "something went wrong"
    exit 1
fi

ip=$(awk -F, '{print $1}' <<<$OUTPUT)
port=$(awk -F, '{print $2}' <<<$OUTPUT)
```



#### Capturar salida 2
``` bash
data=$(
    zenity --forms --title="New book" --text="Add new book" \
       --add-entry="Title" \
       --add-entry="Author" \
       --add-entry="Price" \
       --add-entry="Quantity Available" \
       --add-entry="Quantity sold"  
)
case $? in
     1) echo "you cancelled"; exit 1 ;;
    -1) echo "some error occurred"; exit -1 ;;
     0) IFS="|" read -r title author price qtyA qtyS <<< "$data" ;;
esac
```


#### Cuadro combinado:
``` bash
zenity --forms --title "Window title" --text "Combo name" --add-combo "Insert your choice." --combo-values "a|b|c|d|e"

ó:

array=(a b c d e)
value=$(zenity --entry --title "Window title" --entry-text "${array[@]}" --text "Insert your choice.")

```

### Códigos de salida
Zenity devuelve los siguientes códigos de salida:

* 0 El usuario ha presionado Aceptar o Cerrar 

* 1 El usuario presionó Cancelar o usó las funciones de la ventana para cerrar el cuadro de diálogo.

* -1 Ha ocurrido un error inesperado.

* 5 El cuadro de diálogo se ha cerrado porque se ha alcanzado el tiempo de espera.

## **Fuente de buenos ejemplos:** [https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/](https://ostechnix.com/zenity-create-gui-dialog-boxes-in-bash-scripts/)

De allí obtuve el ejemplo de la barra de dezplazamiento:

``` bash
(
  echo 10
  echo "# Updating repository Index"
  sleep 5

  echo 15
  echo "# Reading input files"
  sleep 5

  echo 70
  echo "# Installing packages..."
  sleep 5

  echo 100
  echo "# Package Installation completed!"
) | zenity --title "Package Installation Progress Bar" --progress --auto-close
```
#####  Cuadro de diálogo de progreso

Para acceder a la lista de opciones admitidas para el cuadro de diálogo de la barra de progreso, ejecute el siguiente comando:

``` bash
zenity --help-progress
```
La línea que contiene solo el número con el echocomando se considerará como el porcentaje del progreso.
La línea que comienza con el #símbolo en el echocomando se imprimirá como mensaje de progreso.

#### De zenity --help-forms

``` bash
Uso:
    zenity [OPCIÓN…]
  
  Opciones del diálogo de formularios
    --forms                                                    Mostrar el diálogo de formularios
    --add-entry=Nombre del campo                               Añadir una entrada nueva en el diálogo de formularios
    --add-password=Nombre del campo                            Añadir una contraseña nueva en el diálogo de formularios
    --add-calendar=Nombre del campo del calendario             Añadir un calendario nuevo en el diálogo de formularios
    --add-list=Listar el nombre del campo y de la cabecera     Añadir una lista nueva en el diálogo de formularios
    --list-values=Lista de valores separados por |             Lista de valores por lista
    --column-values=Lista de valores separados por |           Lista de valores por columnas
    --add-combo=Nombre del campo de la caja combinada          Añadir una caja combinada nueva en el diálogo de formularios
    --combo-values=Lista de valores separados por |            Lista de valores para la caja combinada
    --show-header                                              Mostrar la cabecera de las columnas
    --text=TEXTO                                               Establecer el texto del diálogo
    --separator=SEPARADOR                                      Establecer el carácter separador de la salida
    --forms-date-format=PATRÓN                                 Establecer el formato para la fecha retornada
  
```

## Otros Diálogos Cortos e ImPortantes:

**Fuente Local:** [dialogos.html](dialogos.html)



#### EasyBashGUI [Clic aquí para documentación](easy.md)



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



