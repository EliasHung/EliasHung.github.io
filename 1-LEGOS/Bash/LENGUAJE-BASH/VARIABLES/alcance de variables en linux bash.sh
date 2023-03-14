Tipos de shell, exportar variables con source ó ./ ó /bin/bash y alcance de variables
¿Cuál es la diferencia entre /etc/environment y /etc/profile?


¿Cuál es la diferencia entre /etc/environment y /etc/profile?

        /etc/environment- Este archivo está diseñado específicamente para la configuración de variables de entorno de todo el sistema. No es un archivo de script, sino que consta de expresiones de asignación, una por línea. Específicamente, este archivo almacena la configuración regional y de ruta de todo el sistema.

        /etc/profile- Este archivo se ejecuta cada vez que se ingresa un shell de inicio de sesión de bash (por ejemplo, cuando se inicia sesión desde la consola o mediante ssh), así como también por DisplayManager cuando se carga la sesión de escritorio.



        /etc/environmentno es parte de POSIX, pertenece a PAM (Módulo de autenticación conectable), y solo los programas compilados con soporte PAM pueden usarlo (principalmente sistemas de inicio de sesión, que posteriormente inician el shell o el entorno del usuario). Esto significa que su shell ni siquiera lo lee.

        Puede ver los programas que se usan /etc/environment con grep -l pam_env /etc/pam.d/*.

        Por lo tanto /etc/environment, se usa para establecer variables para programas que generalmente no se inician desde un shell.


        Ejemplo:
        grep -l pam_env /etc/pam.d/*

        daniel@HungServ:~$ grep -l pam_env /etc/pam.d/*
        /etc/pam.d/atd
        /etc/pam.d/cron
        /etc/pam.d/lightdm
        /etc/pam.d/lightdm-autologin
        /etc/pam.d/lightdm-greeter
        /etc/pam.d/login
        /etc/pam.d/polkit-1
        /etc/pam.d/sshd
        /etc/pam.d/su
        /etc/pam.d/sudo
        /etc/pam.d/sudo-i

        Conclusion: ssh, sudo, su, el entorno de escritorio leen  /etc/environment, /etc/profile se lee cuando se ejecuta un inicio de sesion.

Los Shell de inicio de sesion se ven cuando ejecutamos ssh o su - estos son interactivos
LOS Shell de inicio de sesion leen los profiles
LOS PROFILES ESTAN EN /etc/profile y ~/.profile

se inicia un shell de inicio de sesión no interactivo al iniciar sesión de forma remota con un comando pasado a través de una entrada estándar que no es un terminal, por ejemplo ssh example.com <my-script-which-is-stored-locally(a diferencia de ssh example.com my-script-which-is-on-the-remote-machine, que ejecuta un shell no interactivo y sin inicio de sesión).

Cuando inicia un shell en una terminal en una sesión existente (pantalla, terminal X, búfer de terminal de Emacs, un shell dentro de otro, etc.), obtiene un shell interactivo sin inicio de sesión . Ese shell podría leer un archivo de configuración de shell  ~/.bashrc para bash, la configuracion se carga de la ENV variable para shells compatibles con POSIX/XSI como bash cuando se invoca como sh.

cuando se ejecuta un shell de inicio de sesión cualquier configuración ~/.bash_profile, ~/.bash_login y ~/.profile, en ese orden, se ejecutará

Cuando un shell ejecuta una secuencia de comandos o un comando pasado en su línea de comandos, es un shell no interactivo y sin inicio de sesión . 

Para saber si está en un shell de inicio de sesión:

prompt> echo $0
-bash # "-" is the first character. Therefore, this is a login shell.

prompt> echo $0
bash # "-" is NOT the first character. This is NOT a login shell.



Tipos de shell, exportar variables con source ó ./ ó /bin/bash y alcance de variables:



        el comando source mi_script.sh es un alias para . mi_script.sh
        export gobierna qué variables estarán disponibles para nuevos procesos, por lo que si dice

        FOO=1
        export BAR=2
        source /runScript.sh

        entonces $BAR estará disponible en el entorno de runScript.sh, pero $FOO no lo estará.

        para el ejemplo anterior si se desea sustituir source por .
        
        FOO=1
        export BAR=2
        . ./runScript.sh

        Conclusiones: cada vez que se ejecuta un script dentro de un shell, se ejecutan como sub scripts
                para que una variable esté disponible dentro de un sub script hay que exportarla

        Experimento sin export

                externa=existo
                
                el script.sh es:

                #!/bin/bash
                interna=existo
                echo "estas viendo dentro de el script"
                echo "imprimiendo la variable del shell externa (variable fuera del script): "
                echo "externa=$externa"
                echo "imprimiendo variable dentro de el script"
                echo "interna=$interna" 
        
        Resultados: 

                daniel@HungServ:~$ ./script.sh
                estas viendo dentro de el script
                imprimiendo la variable del shell externa (variable fuera del script): 
                externa=
                imprimiendo variable dentro de el script
                interna=existo
                daniel@HungServ:~$ echo $interna

                daniel@HungServ:~$

                *************************************************************************

                daniel@HungServ:~$ . ./script.sh
                estas viendo dentro de el script
                imprimiendo la variable del shell externa (variable fuera del script): 
                externa=existo
                imprimiendo variable dentro de el script
                interna=existo
                daniel@HungServ:~$ echo $interna
                existo
                daniel@HungServ:~$ 

                *************************************************************************

                daniel@HungServ:~$ externa=existo
                daniel@HungServ:~$ /bin/bash $PWD/script.sh
                estas viendo dentro de el script
                imprimiendo la variable del shell externa (variable fuera del script): 
                externa=
                imprimiendo variable dentro de el script
                interna=existo
                daniel@HungServ:~$ echo $interna

                daniel@HungServ:~$                 

        Analisis:

                 
                
                sin exportar con  ./script.sh

                LAS VARIABLES EXISTEN EN:     

                        externa: fuera del script si dentro del script no                
                        interna: fuera del script no dentro del script si
                
                sin exportar con  . ./script.sh

                LAS VARIABLES EXISTEN EN:     

                        externa: fuera del script si dentro del script si                
                        interna: fuera del script si dentro del script si


               sin exportar con  /bin/bash $PWD/script.sh

                LAS VARIABLES EXISTEN EN:     

                        externa: fuera del script si dentro del script no               
                        interna: fuera del script no dentro del script si


        Experimento con export
        
                export externa=existo


        Resultados

                daniel@HungServ:~$ ./script.sh
                estas viendo dentro de el script
                imprimiendo la variable del shell externa (variable fuera del script): 
                externa=existo
                imprimiendo variable dentro de el script
                interna=existo
                daniel@HungServ:~$ echo $interna

                daniel@HungServ:~$


                daniel@HungServ:~$ . ./script.sh
                estas viendo dentro de el script
                imprimiendo la variable del shell externa (variable fuera del script): 
                externa=existo
                imprimiendo variable dentro de el script
                interna=existo
                daniel@HungServ:~$ echo $interna
                existo
                daniel@HungServ:~$ 

                daniel@HungServ:~$ export externa=existo
                daniel@HungServ:~$ /bin/bash $PWD/script.sh
                estas viendo dentro de el script
                imprimiendo la variable del shell externa (variable fuera del script): 
                externa=existo
                imprimiendo variable dentro de el script
                interna=existo
                daniel@HungServ:~$ echo $interna

                daniel@HungServ:~$

        Análisis:
 

                exportando con  ./script.sh

                LAS VARIABLES EXISTEN EN:     

                        externa: fuera del script si dentro del script si                
                        interna: fuera del script no dentro del script si
                
                exportando con  . ./script.sh

                LAS VARIABLES EXISTEN EN:     

                        externa: fuera del script si dentro del script si                
                        interna: fuera del script si dentro del script si


               exportando con  /bin/bash $PWD/script.sh

                LAS VARIABLES EXISTEN EN:     

                        externa: fuera del script si dentro del script si               
                        interna: fuera del script no dentro del script si


Comparando: 

        sin exportar con  ./script.sh                           exportando con  ./script.sh

        LAS VARIABLES EXISTEN EN:                               LAS VARIABLES EXISTEN EN:     

        externa: fuera si dentro  no                            externa: fuera si dentro si 
        interna: fuera no dentro  si                            interna: fuera no dentro si
        
        sin exportar con  . ./script.sh                         exportando con  . ./script.sh

        LAS VARIABLES EXISTEN EN:                               LAS VARIABLES EXISTEN EN:

        externa: fuera si dentro si                             externa: fuera si dentro si                
        interna: fuera si dentro si                             interna: fuera si dentro si


       sin exportar con  /bin/bash $PWD/script.sh               exportando con  /bin/bash $PWD/script.sh

        LAS VARIABLES EXISTEN EN:                               LAS VARIABLES EXISTEN EN:     

        externa: fuera si dentro no                             externa: fuera si dentro si
        interna: fuera no dentro si                             interna: fuera no dentro si

Resumen:

        Cuando se exporta siempre la variable externa puede existir dentro de los scripts se invoque con source o con . ./
        Cuando no se exporta una variable externa solo se puede ver dentro del script si el script se invoco con . ./ o source que es lo mismo.
        Ejecutar con ./script.sh y con /bin/bash $PWD/script.sh  es lo mismo.


