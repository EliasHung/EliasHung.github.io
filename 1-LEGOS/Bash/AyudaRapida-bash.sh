


RESCUERDA QUE SOLO LAS ETIQUETAS TIENEN ALMUADILLAS "#" LOS
COMENTARIOS NO.
PARA QUE LUEGO PUEDAS ENCONTRAR Y MODIFICAR
ETIQUETAS FACILMENTE.
CADA LENGUAJE EN UN DOCUMENTO DISTINTO PARA QUE
EL DEMARCADO DE SINTAXIS SEA EL CORRECTO 
ESTA INTRO DEBE ENCABEZAR TODOS LOS DOCUMENTOS Y EL RESUMEN DE LOS COMANDOS DE BUSQUEDA

#bash

#   Manipulacion de Texto

#       Texto y Documentos

#           Si se encuentra dentro de el documento verdadero
#           si no escribe dentro del documento.

            grep -q JAVA_HOME /etc/environment || echo 'JAVA_HOME="/usr/lib/jvm/java-5-sun"' >> /etc/environment
            El grepcomando devuelve 0 (verdadero) si el patrón se encuentra en el archivo. Entonces, lo anterior dice:

            verifique si JAVA_HOME está configurado en el archivo
            O configure JAVA_HOME en el archivo

            #Insertar texto en PATH Puede hacer esto usando sed para eliminar primero y luego insertar la ruta jdk:

            #!/bin/bash
            sed -e 's|/opt/jdk1.6.0_45/bin:||g' -i /etc/environment 
            sed -e 's|PATH="\(.*\)"|PATH="/opt/jdk1.6.0_45/bin:\1"|g' -i /etc/environment


 #  Importacion de Variables       
 #  toma /etc/environmet y exporta a la sesion actual cada variable
 
        for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g'); done          


#   bash de una linea

#       bash if de una linea
            ifdeunalinea () {
            EJEMPLO 1
            if [ 2 -eq 3 ]; then echo "CRITICAL"; else echo "OK"; fi
            ( [ 2 -eq 3 ] && echo "CRITICAL" ) || echo "OK"


            EJEMPLO 2
            Para resumir las otras respuestas, para uso general:

            Instrucción multilínea si... entonces
            if [ foo ]; then
                a; b
            elif [ bar ]; then
                c; d
            else
                e; f
            fi
            Versión de una sola línea
            if [ foo ]; then a && b; elif [ bar ]; c && d; else e && f; fi
            Usando el operador OR
            ( foo && a && b ) || ( bar && c && d ) || e && f;


            Ejemplo 3
            if [ -f "/usr/bin/wine" ]; then export WINEARCH=win32; fi
            [ -f "/usr/bin/wine" ] && export WINEARCH=win32
            }

#   bash funcion de una linea
        No funciona con parametros
        alias remendarinstall="remienda() { apt --fix-broken install  ; }; remienda"

            

