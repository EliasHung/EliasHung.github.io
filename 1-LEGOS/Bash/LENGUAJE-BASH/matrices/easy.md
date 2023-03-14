# EasyBashGUI

**Fuente:**[https://github.com/BashGui/easybashgui](https://github.com/BashGui/easybashgui)

EasyBashGUI es una biblioteca de funciones Bash para *BSD y GNU/Linux que tiene como objetivo brindar funciones GUI simples usando yad, gtkdialog, kdialog, zenity, Xdialog, (c)dialog, whiptail o bash incorporados dependiendo de si KDE o GNOME se están ejecutando o no, Yad /Gtkdialog/Xdialog instalado o no y, eventualmente, el servidor X ejecutándose o no.

``` bash
Proyecto EasyBashGUI.


Introducción

EasyBashGUI es una biblioteca de funciones Bash compatible con Posix que tiene como objetivo brindar funciones GUI simples usando yad, gtkdialog, kdialog, zenity, Xdialog, dialog o whiptail dependiendo de KDE o GNOME en ejecución o no, Yad, Gtkdialog o Xdialog instalado o no y servidor X corriendo o no ((c)diálogo o cola de látigo es el mínimo). Por lo tanto, si el programador bash escribe: "mensaje 'Gracias por usar este programa'", no tiene que preocuparse en qué entorno se ejecuta su programa: es suficiente con al menos (c)dialog o whiptail instalado, y el programa funcionará como se espera . Obviamente, si el usuario también tiene instalado KDE, GNOME o gtkdialog/Xdialog (y está en una sesión X), el programa tendrá "otro aspecto", pero el flujo lógico sigue siendo exactamente el mismo.
Puede forzar el uso del widget a través de la variable "supermodo" (valores posibles: "yad", "gtkdialog", "kdialog", "zenity", "Xdialog", "dialog", "none";
por ejemplo: >exportar supermodo="kdialog" && fuente easybashgui && mensaje Hello ).
NOTA sobre el modo "ninguno": debe asegurarse de que STDERR *no* sea redirigido, para poder ver las cajas de shell en su terminal.

En la "suite" de EasyBashGUI hay un iniciador ("easybashgui"), un iniciador que alterna algunas opciones de depuración ("easybashgui-debug"), una biblioteca de widgets ("easybashgui_X.X.X.lib") y un script independiente (más bien antiguo hoy en día) para crear cuadros de diálogo externamente ("easydialog-legacy"). Además, también hay otra biblioteca ("easybashlib") para funciones auxiliares opcionales (gracias a ella, ya no necesita usar la función "clean_temp ()" al final de sus scripts EBG).

```
``` bash
Library functions.

message
ok_message
alert_message
notify_message
text
question
input
menu
tagged_menu
list
fselect (= "file select" )
dselect (= "directory select" )
wait_seconds
wait_for
terminate_wait_for
progress
adjust
notify (*)
notify_change (*)

(* => only if you have "yad" installed)


```
``` bash
How to install and use.

Extract all files...
(e.g.: >tar -xzvf EasyBashGUI_X.X.X )

Cd in ./EasyBashGUI source dir...
(e.g.: >cd ./EasyBashGUI_X.X.X )

Install it (as root)...
(e.g.: >sudo make install )
 
Uninstall it (as root)...
(e.g.: >sudo make uninstall )

That's it !!!!!



If you want use it in your scripts, simply source "easybashgui" before use...
(e.g.: "source easybashgui" )


E.g.:
-------------------
#!/bin/bash
source easybashgui
#
message "this"
input 1 ( "that" )
menu "this" "that"
list +"you" -"me" +"her"
...
etc.etc.
...

```
``` bash

Synopsis.

question -> "[text]"                 =>       ( 1 argument, box output to exit code and STDERR ) (*)
message -> "[text]"                  =>       ( 1 argument )
alert_message -> "[text]"            =>       ( 1 argument )
ok_message -> "[text]"               =>       ( 1 argument )
notify_message -> <-i "[icon]"> "[text]" =>   ( 1 option, 1 argument )
text                                 =>       ( STDIN, NO argument, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (^)
wait_seconds -> "[integer]"          =>       ( 1 argument )
wait_for -> "[text]"                 =>       ( 1 argument, PID to kill to "wait_for__PID" variable and STDERR ) (@)
terminate_wait_for                   =>       ( 1 argument only in easydialog, otherwise, NO argument ) (@)
fselect -> "<init. dir.>"            =>       ( 1 <optional> argument, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (#)
dselect -> "<init. dir.>"            =>       ( 1 <optional> argument, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (#)
input -> 1 "<label 1>" "[init 1]"    =>       ( 2-3 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
input -> 2 "[label 1]" "[init 1]" "[label 2]" "[init 2]"                     => ( 5 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
input -> 3 "[label 1]" "[init 1]" "[label 2]" "[init 2]" "[label 3]" "[init 3]" => ( 7 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
menu -> "[item 1]" ... "[item n]"    =>       ( [n] arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (%)
tagged_menu -> "[item 1]" "[tag 1]" ... "[item n]" "[tag n]"    =>       ( [n*2] arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR ) (%)
list -> <+|->"[item 1]" ... <+|->"[item n]"    =>       ( [n] arguments, optionally prefixed by "+"(plus) or "-"(minus), box output to "${dir_tmp}/${file_tmp}" and STDERR ) (%)
progress -> "[text]"                         =>       ( percent with or without '%' in STDIN, 1 argument )
progress -> "[text]" "[elements number]"     =>       ( "PROGRESS" string in STDIN, 2 arguments )
adjust -> "[text]" "[min]" "[init]" "[max]" => ( 4 arguments, box output to "${dir_tmp}/${file_tmp}" and STDERR )
notify -> <-c "[click command (for mouse left button)]"> <-i "[icon_good]#[icon_bad]"> <-t "[tooltip_good]#[tooltip_bad]"> "[menu item 1]" "[menu command 1]" ... "[menu item n]" "[menu command n]"		=>       ( 3 options, [n*2] mandatory arguments )
notify_change -> <-i "[new icon]"> <-t "[new tooltip]"> "[good|bad]"		=>      ( 2 options, 1 mandatory argument ) 
```
``` bash

(*) = "0" el estado de salida es "SÍ", "1" el estado de salida es "NO", otros códigos de salida que debe hacer salir del programa: normalmente en un script solo tiene que verificar el estado de salida para conocer la elección del usuario;
(^) = función de texto escribe texto en STDIN en el archivo "${dir_tmp}/${file_tmp}" y (solo) para kdialog, zenity y Xdialog también puede editar texto para escribir;
(@) = la función "esperar" crea una ventana con un texto y devuelve el control al programa principal... después de un trabajo, puede cerrar la ventana a través de la función "terminar_esperar" (no necesita argumento);
(#) = tenga cuidado que si está en "modo consola" o sin X, a través de cdialog, la selección se hace con la tecla ESPACIO, y NO con la tecla enter: recuérdelo;
(%) = las funciones "menú" y "lista" difieren en cuanto a las opciones: el menú permite una sola opción, la lista permite múltiples opciones; desde la versión 7.1.0, puede usar tagged_menu (): genera etiquetas (por ejemplo: "tagged_menu 1 A 2 B" -> si el usuario selecciona la etiqueta "A", la función genera el elemento "1");
```
``` bash
Since EasyBashGUI v.1.2.4, all windows functions support options "<-w|-width> [integer]", and "<-h|-height> [integer]" for custom window size (note: not used for "notify_message"):
```

``` bash

Library examples:
1)
question "Do you like Contry music ?"
answer="${?}"
if [ ${answer} -eq 0 ]
	then
	ok_message "You do like it :)"
elif [ ${answer} -eq 1 ]
	then
	alert_message "You don't like it :("
else
	ok_message "See you"
	exit 0
fi

2)
echo -e "What's your name?\n\nMy name's:\nVittorio" | text

3)
wait_for "I'm sleeping 4 seconds... good night..."
sleep 4
terminate_wait_for

4)
fselect
file="$(0< "${dir_tmp}/${file_tmp}" )"

5)
input 1 "(write here IP address)"
input 1 "Please, write IP address" "192.168.1.1"
input 3 "Username" "root" "IP address" "192.168.0.1" "Destination directory" "/tmp"
IFS=$'\n' ; choices=( $(0< "${dir_tmp}/${file_tmp}" ) ) ; IFS=$' \t\n'
user="${choices[0]}"
ip="${choices[1]}"
dir="${choices[2]}"

6)
for i in 10 20 30 40 50 60 70 80 90 100
	do
	echo "${i}"
	sleep 2
done | progress "This is a test progress..."

7)
adjust "Please, set Volume level" 15 40 75

8)
women=( Angela Carla Michelle Noemi Urma Marisa Karina Anita Josephine Rachel )
for (( index=0 ; index < ${#women[@]} ; index++ })) 
	do
	today_prefered_woman="${women[${index}]}"
	kiss "${today_prefered_woman}"
	sleep 1
	#
	# Job done !!
	# then...
	echo "PROGRESS"
	#
done | progress "This is a _LOVE_ progress..." "${#women[@]}"
# if you use "PROGRESS" string in STDIN do not forget second argument ( "[elements number]" )

9)
notify -t "Good tooltip:OK#Bad tooltip:BAD" -i "/usr/local/share/pixmaps/nm-signal-100.png#gtk-fullscreen" "Xclock" "xclock" "Xcalc" "xcalc"
#
while :
	do
	menu GOOD BAD
	answer=$(0< "${dir_tmp}/${file_tmp}" )
	#
	if [ "${answer}" = "GOOD" ]
		then
		notify_message "Changed in \"good\" ..."
		notify_change "good"
	elif [ "${answer}" = "BAD" ]
		then
		notify_message "Changed in \"bad\" ..."
		notify_change -i "gtk-help" -t "This tooltip is bad" "bad"
	else
		exit
	fi
	#
done





( For the old "easydialog-legacy" examples, you would launch it simply with "-h" option )

```
``` bash
Nota sobre el modo de consola.

EasyBashGUI no funciona con el "diálogo" original (el antiguo) que es muy limitado; si tiene la primera versión "dialog" en su caja, instale "cdialog" y alias o vincule "dialog" a cdialog. No hay problema en caso de que tenga instalado al menos "whiptail": desde la versión 4.0.0, EasyBashGUI puede usarlo en lugar de (c)dialog.
Desde la versión 5.0.0, puede usar EasyBashGUI incluso si NO hay ningún WIDGET instalado (es decir: no gtkdialog, no kdialog, no zenity, no Xdialog, no (c)dialog, no whiptail... doh!!!!!). Para usar EBG "super bare", simplemente elimine la biblioteca ".lib" de su ruta, o establezca var "supermodo" en "ninguno" antes de obtener el abastecimiento de easybashgui (por ejemplo: >exportar supermodo="ninguno" && fuente easybashgui && mensaje "Hola mundo..." )
```
``` bash
Nota sobre el modo gtkdialog.

EasyBashGUI establece declaraciones de salida de gtkdialog como variables a través de "eval". De esta manera, en teoría, podría ser posiblemente peligroso; sin embargo, hasta el momento, no conozco ninguna forma alternativa...
```