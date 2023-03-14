# Bash notificar cambios  cuando cambia un archivo.

## Con inotifywait

``` bash

while [[ "true" == "true" ]]; do
        inotifywait -q -e close_write ruta_archivo |
        while read -r filename event; do
                comandos_a_ejecutar   
        done  
done
    
```

## Con systemmd y Una unidad de ruta:
**Fuente:**  [https://www.freedesktop.org/software/systemd/man/systemd.path.html](https://www.freedesktop.org/software/systemd/man/systemd.path.html)

**Fuente:**  [Configurar unidad de ruta: https://www.putorius.net/systemd-path-units.html](https://www.putorius.net/systemd-path-units.html)

**Fuente:**  [ entender las unidades de sistema: https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)

## Con entr

**Fuente:**  [Man: https://man.archlinux.org/man/community/entr/entr.1.en](https://man.archlinux.org/man/community/entr/entr.1.en)

**Fuente:**  []()

``` bash

Instalar:
 - sudo apt-get install entr
```
### ¿Cómo usar entr?

``` bash

* Si tiene un example.txtarchivo y desea monitorearlo y ejecutar un comando cada vez que se cambia:
        -ls example.txt | entr echo "watching..."

* Otro uso básico es que primero defina su script bash y lo haga ejecutable, luego ejecute este comando.
        - find . -type f | entr "./run.sh"

        find . -type f devuelve una lista de archivos dentro del directorio actual de forma recursiva.
        El resultado se canaliza luego al entr comando, ejecutando el script run.sh.

* Usos Varios:
        - ls -d * | entr sh -c 'make && make test'
        - ls *.css *.html | entr reload-browser Firefox
        - echo file.txt | entr echo Changed!

* Para el uso de directorios -d, pero debe usarlo en el ciclo, por ejemplo:
        - while true; do find path/ | entr -d echo Changed; done
        ó:
        - while true; do ls path/* | entr -pd echo Changed; done

* Otra forma:
        - #!/bin/bash
        - exec entr /usr/local/bin/do_stuff < <(echo /path/to/file)

* Correr en otro  lenguaje:
        - ls hello_world.rb | entr -r ruby hello_world.rb
        
        Cuando cambia hello_word.rb ejecuta ruby hello_world.rb

```



### entr Ejemplos:

``` bash


Reconstruya un proyecto si los archivos de origen cambian, limitando la salida a las primeras 20 líneas:
- find src/ | entr -s 'make | head -n 20'

Inicie y vuelva a cargar automáticamente un servidor node.js:
        - ls *.js | entr -r node app.js

Borre la pantalla y ejecute una consulta después de que se actualice el script SQL:
        - echo my.sql | entr -cp psql -f /_

Reconstruya el proyecto si se modifica o agrega un archivo fuente al directorio src/:
        - while sleep 0.1; do ls src/*.rb | entr -d make; done

Recargar automáticamente un servidor web o terminar si el servidor sale
        - ls * | entr -rz ./httpd

```
### Utilizar entr con git

**Fuente**: [https://jvns.ca/blog/2020/06/28/entr/](https://jvns.ca/blog/2020/06/28/entr/)

### entr pagina man  page

``` bash
NAME
entr - run arbitrary commands when files change
SYNOPSIS
[-cdpr ] utility [argument ... ] [/_ ]
DESCRIPTION
A list of files provided on the standard input and the utility is executed using the supplied arguments if any of them change. waits for the child process to finish before responding to subsequent file system events. A TTY is also opened before entering the watch loop in order to support interactive utilities.

The arguments are as follows:

-c
Execute /usr/bin/clear before invoking the utility specified on the command line.
-d
Track the directories of regular files provided as input and exit if a new file is added. This option also enables directories to be specified explicitly. Files with names beginning with `.' are ignored.
-p
Postpone the first execution of the utility until a file is modified.
-r
Reload a persistent child process. SIGTERM is used to terminate the utility before it is restarted. A process group is created to prevent shell scripts from masking signals. waits for the utility to exit to ensure that resources such as sockets have been closed.
The first occurrence of /_ on the command line will be replaced with the absolute path of the first file that was modified. If the restart option is used the first file under watch is treated as the default.

ENVIRONMENT
If PAGER is undefined, entr will assign /bin/cat to prevent interactive utilities from waiting for keyboard input if output does not fit on the screen.
EXIT STATUS
The utility exits with one of the following values:
0
SIGINT or SIGTERM was received
1
No regular files were provided as input or an error occurred
2
A file was added to a directory and the directory watch option was specified

EXAMPLES
Rebuild a project if source files change, limiting output to the first 20 lines:
$ find src/ | entr sh -c 'make | head -n 20'
Launch and auto-reload a node.js server:

$ ls *.js | entr -r node app.js
Clear the screen and run a query after the SQL script is updated:

$ echo my.sql | entr -p psql -f /_
Rebuild project if a source file is modified or added to the src/ directory:

$ while true; do ls src/*.rb | entr -d make; done
 
```




## Código simple:


### Ejemplo 1 con Whatch.
**Fuente:** [https://superuser.com/questions/624709/linux-execute-given-command-when-file-directory-changes](https://superuser.com/questions/624709/linux-execute-given-command-when-file-directory-changes)


Eso verifica cada cambio de archivo dentro de ese directorio.

Pequeña explicación: watch -gsale con el código de estado 0 cuando encuentra un cambio en la salida del comando. Cuando sale, ejecuta los siguientes comandos vinculados con expresiones de shell condicionales (pueden ser tantos como desee). Luego simplemente repites eso para siempre hasta que golpeas Control-C(para eso está trap exit SIGQUIT SIGINT).

Por supuesto, le gustaría modificar un poco este script, como -n2el intervalo de tiempo para las actualizaciones. Cuanto más lo actualice, más recursos gastará.

Para archivos individuales, recomendaría usar el ls -l --time-format=+%s /path/to/file /path/to/another_filecomando, ya que verifica las fechas de modificación e incluso los cambios de permisos y propiedad.

Seguramente existe un método mejor y más optimizado para hacer esto, pero este enfoque funciona y definitivamente consume menos recursos que Guard. Ahora, todo depende de la escalabilidad. Si va a enumerar recursivamente todos los archivos con todos sus atributos cada milisegundo, seguramente consumirá más, pero definitivamente no necesita eso. Simplemente establezca un intervalo más grande, digamos 2 segundos como el anterior, tal vez 10 o 30 si su proyecto no cambia tanto y no le importa esperar un tiempo para que se active el comando. Y en mi opinión, este enfoque es bastante bonito y sencillo.

### Ejemplo 2 con un Ciclo y stat.
**Fuente:** [https://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes](https://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes)

``` bash

#!/bin/bash

### Set initial time of file
LTIME=`stat -c %Z /path/to/the/file.txt`

while true    
do
   ATIME=`stat -c %Z /path/to/the/file.txt`

   if [[ "$ATIME" != "$LTIME" ]]
   then    
       echo "RUN COMMAND"
       LTIME=$ATIME
   fi
   sleep 5
done

```