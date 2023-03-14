---
title: Tron Heurística Diseño del Programa.
summary: Ideas y herramientas y descripciones del programa de heurística.
description: Descripción del Programa.
path: file:///home/daniel/tron/programas/heuristic/Leeme.md
authors:
    - Elías Hung.

date: 2020-02-24
some_url: file:///home/daniel/tron/programas/heuristic/Leeme.md
---

# Diseño del programa de heurística:
##### [Disponible aquí](file:///home/daniel/tron/programas/heuristic/Leeme.md)

## Ayudantes:

### pydoc shdoc mkdocs
[ver documentación shdoc](manuales/shdoc.md) 


## Estructura de Carpetas



  1.La forma más eficiente de realizar una documentación, para ti mismo como programador he investigador es en el mismo instante en que programas o investigas, como usuario es diferente porque los manuales te llevan paso a paso por las características principales de uso, pero no son útiles para el hack.



>Hack en este contexto es modificar los programas para que se adapten a tus necesidades, es decir programar con lo que ya has hecho o con lo que otro ha creado.

        
### Posición de Carpetas: 

 

 Las carpetas de ayuda de cada programa pueden estar en un lugar central en un servidor web, pero cuando se programa,  la ayuda se coloca dentro del código, entonces: ***1. ¿Cómo ubicamos físicamente la ayuda?*** para responder esta pregunta hay que saber: ***2. ¿Cuál es la lista de características relacionadas de las herramientas encontradas?*** , herramientas como mkdocs, pydoc...  con estas ventajas y la necesidad:( ***3. ¿Qué necesito en cada situación para que la información esté rápidamente accesible?)*** ; se toma una decisión de ubicación de archivos de ayuda.


    
#### 2. Lista de Características de las herramientas.

##### Pydoc:
``` bash

python3 -m pydoc -w programa.py
```
Es el comando utilizado para generar html en la carpeta del .py entonces **hay que configurar una plantilla snippet** en cada editor de código (code y micro) para que contenga el encabezado estándar del programa a documentar este es un ejemplo de plantilla:

``` python


"""Título del módulo o del Programa

Funcionalidad del programa, entradas y salidas del programa.

Descripción de dependencias si las tiene

Funciones si se importa como módulo:
(también pueden ser funciones a secas)

    * get_spreadsheet_cols - devuelve los encabezados de columna del archivo
    * main - la función principal del script
"""

(acá el programa, las importaciones)

def definiendo la primera clase(Parámetros):

"""Que hace la clase...

    Parameters
    ----------
    Parametros : clase o tipo
       
        Descripción del parámetro...
    
    Returns
    -------
    list
        Descripción de la salida o retorno
    """



def main():

definiciones del main...
if __name__ == "__main__":
    main()

```
 [clic aquí para ver el ejemplo completo](ejemplos/ejemplo-python.md)

##### shdoc:
[ver documentación shdoc](pages/shdoc.md)

``` bash

 shdoc < mi-shell-script.sh > doumento.md

```
>Con shdoc también hay que configurar una plantilla, para los editores

La plantilla sugerida para shdoc es:
``` bash
#!/bin/bash
# @file libexample
# @brief A library that solves some common problems.
# @description
#     The project solves lots of problems:
#      * a
#      * b
#      * c
#      * etc

# @description My super function.
# Not thread-safe.
#
# @example
#    echo "test: $(say-hello World)"
#
# @arg $1 string A value to print
#
# @stdout Output 'Hello $1'.
#   It hopes you say Hello back.
# @stderr Output 'Oups !' on error.
#   It did it again.
#
# @exitcode 0 If successful.
# @exitcode 1 If an empty string passed.
#
# @see validate()
# @see Documentation generated using [shdoc](https://github.com/reconquest/shdoc).


```


###### pydoc:

Pydoc se ejecuta con un comando de bash y su salida es un documento html, o una pagina web en un servidor
###### shdoc:

Se ejecuta como bash también y su salida un documento markdown (.md)


##### Mkdocs:

Mkdocs acepta metadatos como éstos para formar los títulos de las páginas

### Metadatos de estilo YAML:

Los metadatos de estilo YAML consisten en pares clave/valor YAML envueltos en delimitadores de estilo YAML para marcar el inicio o el final de los metadatos. La primera línea de un documento debe ser ---. Los metadatos terminan en la primera línea que contiene un delimitador final (ya sea ---o ...). El contenido entre los delimitadores se analiza como YAML .
``` yaml
---
title: My Document
summary: A brief description of my document.
authors:
    - Waylan Limberg
    - Tom Christie
date: 2018-07-10
some_url: https://example.com
---
This is the first paragraph of the document.
```
YAML es capaz de detectar tipos de datos. Por lo tanto, en el ejemplo anterior, los valores de titley summaryson some_urlcadenas, el valor de authorses una lista de cadenas y el valor de datees un datetime.dateobjeto. Tenga en cuenta que las claves YAML distinguen entre mayúsculas y minúsculas y MkDocs espera que las claves estén en minúsculas. El nivel superior de YAML debe ser una colección de pares clave/valor, lo que da como resultado que dictse devuelva un Python. Si se devuelve cualquier otro tipo o el analizador YAML encuentra un error, entonces MkDocs no reconoce la sección como metadatos, el metaatributo de la página estará vacío y la sección no se eliminará del documento.

##### [Mkdocs-Material Desing](https://squidfunk.github.io/mkdocs-material)

####Documentación:


* [Referencia](https://squidfunk.github.io/mkdocs-material/reference/)
* [Extensiones](https://squidfunk.github.io/mkdocs-material/setup/extensions/python-markdown-extensions/#python-markdown-extensions)



#### Metadatos

Para este Mkdocs, hay algunos metadatos:
el siguiente metadato se coloca en la entrada para impulsar su búsqueda:

``` yaml
---
search:
  boost: 2 
---
```

###### vincular secciones


Para vincular una página a una sección, cree un nuevo documento con el nombre index.md en la carpeta respectiva y agréguelo al comienzo de su sección de navegación:

```  yaml
nav:
  - Section:
    - section/index.md
    - Page 1: section/page-1.md
    ...
    - Page n: section/page-n.md

```

###### Agregar Etiquetas:

Cuando el complemento de etiquetas incorporado está habilitado, se pueden agregar etiquetas para un documento con la tagspropiedad de materia preliminar. Agregue las siguientes líneas en la parte superior de un archivo Markdown:

``` yaml
--- 

tags:
  - HTML5
  - JavaScript
  - CSS
      
---

```
La página ahora se representará con esas etiquetas sobre el título principal y dentro de la vista previa de búsqueda, que ahora permite encontrar páginas por etiquetas .

¿Cómo establecer etiquetas para una carpeta completa?
Agregar un índice de etiquetas¶
El complemento de etiquetas incorporado permite definir un archivo para representar un índice de etiquetas , que puede ser cualquier página que forme parte de la navsección. Para agregar un índice de etiquetas, cree una página, por ejemplo tags.md:

``` markdown    

# Tags

Following is a list of relevant tags:

[TAGS]

```
El [TAGS]marcador especifica la posición del índice de etiquetas, es decir, se reemplaza con el índice de etiquetas real cuando se representa la página. Puede incluir contenido arbitrario antes y después del marcador:

    
 # recordar agregar:

 tags.md


##### Alinear Imágenes 

[Click aquí para ver como Alinear Imagenes](https://squidfunk.github.io/mkdocs-material/reference/images/#image-captions)

##### Para Colocar el sitio  Offline:

En la configuración YAML:

```  yaml
 plugins:
  - offline
```
>creo que la ubicación física en el disco se puede guardar como metadato..?


#### 3. ¿Qué necesito en cada situación para que la información esté rápidamente accesible?

> Recordemos que contestaremos las preguntas 2 y 3 para contestar la 1.

Entonces en cuanto al almacenamiento debe haber una sola Solución de Biblioteca, así que vamos a hacer una prueba de mkdocs, esta prueba consiste en ver como ordena todas las entradas de información posibles:

Resultados para Mkdocs

##### Entradas de Información:

1. - [ ] Video. (De las marcas de los videos)  
2. - [ ] Pdf. De las marcas también
3. - [x] Html.
4. - [ ] Audio.
5. - [x] Mhtml.(no soporta todos los sitios web y en HTML con monolit)
6. - [x] Imágenes (Capturas de teléfono o Pantalla).
7. - [x] Markdown.
8. - [x] Recortes de código de copiar y pegar
9. - [x] Documentación embebida en el código fuente. 
10. - [x] Sesiones de Navegador Guardadas (con monolith)
     * (vinculando el nombre de carpeta de una
     sesión a un .md particular para tener soporte de sesiónWeb)
11. - [ ] Marcadores de Navegador guardados 
    Exportando los marcadores a html y Raspando la pagina para sacar los marcadores convenientes 
    Descargando las webs como documentación.

Si una Solución de Biblioteca puede ordenar automáticamente Todos los formatos y realizar búsquedas con respuestas entendibles dentro del sistema de biblioteca como en contexto de consola, entonces esa solución es la correcta el "lugar" de esa biblioteca será la respuesta a la pregunta 1. 

Quitando lo innecesario para la primera fase (Notas básicas de clases) y lo
que mkdocs ya cubre, nos queda:

1. - [ ] Video. (De las marcas de los videos)  
2. - [ ] Pdf. De las marcas también

Entonces podemos Hacer un Plan de Realización de la App heuristica desde la primera Fase:

# [Plan de Realización de la App heurística Clic aquí.](proyecto/fase1.md) 
 
##### Entradas pre-editadas:



>Entradas de ***recortes snipets***, ***resúmenes de procedimientos*** (como configurar...), ***resúmenes de 
comandos*** de programas (VLC command line...) ***hojas de trucos***, pequeños ***scripts***:

Las entradas pre-editadas son recortes de información de texto que se utilizarán de forma rápida, y en contexto: ***programando, administrando en tiempo real servidores, servicios...***

Entonces para este tipo de notas se necesita un programa especial que permita guardar y recuperar las notas rápidamente pero que también de alguna manera se integre a el ecosistema de la biblioteca.
Este sistema gestiona información del momento por tanto lo llamaré chismoso.

##### Chismoso:

Chismoso es el punto final, es la manera de tener la información siempre a la mano y de crecer como programador, chismoso almacenará snippets, resúmenes, procedimientos y hasta archivos TODO.

Para que chismoso funcione debe haber en la biblioteca un sistema de carpetas que refleje la clasificación de la información. Entonces chismoso podrá pedir el inicio de cualquier rama e ir preguntando hacia donde ir con un simple ls de bash.

Ag permite buscar en determinada carpetas saltando otras, así que se puede introducir solo el nombre de la carpeta (o tema) y chismoso irá directamente a ese tema.

Creo que lo mejor será que de ahora en adelante todas las entradas **pre-editadas** deberán crearse en markdown, (al menos con títulos "#" y llamados ">") de esta (para los estudiantes será el primer curso) de esta manera se garantiza que con un esfuerzo regular, (y al practicar markdown pequeño), la información sea altamente comprensible.

###### Estándar de Chismoso: 

Para que la información sea recuperable como una base de datos hay que practicar un estándar mínimo al guardar la información:

* En lo que respecta a los trozos código fuente (recortes snipets) debe estar identificado siempre de principio a fin.con un nivel ###### seis(6), al menos. de esta manera si se desea agregar mas clasificación se hará del nivel 5 hasta el 1. al leer el archivo el script de bash usará Ag para extraer el nombre_título#6 hasta el próximo título 6. Así se recuperará la información al vuelo.

* Todas las entradas tendrán una clasificación que será registrada, como un tipo: ***recortes***, ***snippets***, ***resumen de procedimientos*** (como configurar...), ***resumen de comandos*** de programas (VLC command line...) ***hoja de truco***, pequeños ***script***. son buenas etiquetas para comenzar.

* El lenguaje, o tema  va primero, después el tipo y luego el nombre de la entrada pre-editada si alguno de estos elementos tiene varia palabras irá entre comillas.

* Para terminar la entrada se finalizará con \# fin


##### Ejemplo:
##### \# bash recorte  "if de una linea".
##### ...cuerpo o contenido de la entrada...
##### \# fin

---
#### Chismoso Diseño:

1. Al teclear chismoso, bash mostrará el árbol de clasificaciones para poder elegir donde se guardará o si se creará una clasificación nueva, para eso se puede utilizar br. Buscar en la doc hay un caso de eso.

2. Preguntará sobre las tres cosas fundamentales( ***Entradas pre-editadas*** ):

    * Tipo.
    * Lenguaje, tópico o tema.
    * Nombre de la entrada.
    
3. Chismoso buscará la entrada, y dará una 

recordar tomar la entrada de tipo para colocar la plantilla de entrada salida parámetros etc si es una clase o función 

3. Se abrirá micro con un archivo auxiliar, para introducir la entrada, este archivo de texto ya contiene el markdown con el encabezado de la entrada y el \# fin de la entrada. solo para escribir dentro.
 
    * Si es un nuevo archivo se creará 
 
 


# Solución a como hacer entrar cualquier texto rápido desde cualquier parte (chuletas)

* Si necesito escribir cualquier cosa rápido como un elemento de markdown puedo hacer un script de encapsularon, lo que hará es presentar opciones comunes en un menú, con: titulo, lenguaje-tópico-tema, y nombre_entrada, como metadatos: como autor, fecha, resumen... y lo maquetará a la manera markdown para MKdocs luego de terminado ubicará el documento markdown en la carpeta correcta de Mkdocs.

* Si se va a trabajar con un documento de programación en $programas, se supone que es un programa para producción, entonces cada carpeta programa, de $programas debe estar representada en $biblioteca/docu/programas, cuando se comienza a realizar un script en esta carpeta, ya debe existir por cada documento en la carpeta programas un documento igual en la carpeta /docu/programas de la biblioteca.

* Los scripts se escriben de forma arbitraria, aquí uno de python, Javascript, allá sh, pero al crear por primera vez un programa, se hará por medio del script para que facilite la carga del tipo de encabezado de acuerdo al tipo de documento. Una vez creado el programa, solo habrá que correr otro script, para convertir cada encabezado de programa en markdown y guardarlo en la carpeta correcta.

* Para que todas las entradas tengan título legible (por ejemplo home en lugar de index.md) se estandariza que siempre el el programa preguntará por el título de la entrada, y esta será tanto el **primer título de primer nivel** , como el title metadato del documento markdown. Así MKdocs lo asignará al nombre de la pág, 

* También se puede enviar consultas con partes de un título con un script, el título en este archivo, se envía a Mkdocs, para su búsqueda con un curl u otra cosa. 

* Se puede buscar de manera interna con el buscador de plata y buscar cualquier palabra dentro de la documentación  y devolver el nombre del archivo, y así introducir este nombre en el buscador de Mkdocs (probar esta opción con calma para ver que ofrece mejores resultados)

* Si la documentación se genera como un recorte web, se utiliza la consola para guardar la página fuente, y dependiendo si lleva código o no se usa markdown.

* Si la documentación se genera de un video, se ejecutará un script que guarde la posición o captura de pantalla del video un video siempre se ve dentro del contexto de un curso, un curso es una carpeta con clases, ya el programa de cursos abre los archivos relacionados con cada clase, y en cada clase, habrá una carpeta de prácticas, dentro de ella los apuntes.

* Como las clases son más susceptibles a ser borradas conforme nos volvemos más diestros en un tema, los apuntes deben conformar otro árbol  de carpetas, recomiendo colocar las versiones de los programas para así facilitar el borrado cuando estos caduquen, también la fecha (para poder borrar entradas viejas de un tema determinado) este árbol de apuntes guarda las posiciones (enlaces) de pdf, y de los videos junto con la pagina markdown así como los links a los archivos mhtml (los verdaderamente importantes)

* Cuando se utiliza shdoc [ver documentación shdoc](pages/shdoc.md) el sistema coloca la plantilla automáticamente antes de comenzar a editar el documento, luego lo convierte en .md, y convertido en .md te pregunta por los demás metadatos para incluirlos con manipulación de texto antes de sincronizar la documentación en la biblioteca. 

>creo que la ubicación física en el disco se puede guardar como metadato.. si se puede ver: [Metadatos de estilo YAML en este documento.](#metadatos-de-estilo-yaml)
* Si se puede guardar la ubicación física del archivo que generó el markdown como metadato se puede entonces con un script comprobar que archivos existen en la documentación que no tienen una entrada de programa existente en físico en disco. de esta forma se puede eliminar archivos no deseados.

* Todos los programas deben hacerse en dentro de la carpeta tron, específicamente en la carpeta programas o en la carpeta scripts.


  
>NOTA 2: Hay que tener en cuenta las herramientas que se van anexando o descubriendo, por ejemplo: que más puede hacer el buscador de plata Ag...

>NOTA 3: Utilizar yaml para registrar las sesionesWeb, md abiertos, documentos de programación abiertos, pdf abiertos, videos abiertos (y marcadores de videos), ... entradas abiertas y guardarlas en en archivo de sesión recuperable.

>Nota 4: Buscar la forma que ç añada párrafos o retornos de carro en markdown.

>Nota 5: Investigar br (broot) para selecionar carpetas o archivos en un script y así utilizarlo en el sistema de sesiones de Nota 3 (ACTUALIZACIÓN): lo encontré en  [https://dystroy.org/broot/tricks/#a-generic-fuzzy-finder](https://dystroy.org/broot/tricks/#a-generic-fuzzy-finder) , también ver:  [Un buscador difuso genérico en este documento](#un-buscador-difuso-genérico) 

>Nota 6: Para Un sistema de sesiones de archivo de terminal se puede crear una variable de entorno fija que vaya registrando (y guardando cada cierto tiempo) la sesión que se está trabajando, así la sesión será migrable e imune a interrupciones, fallas y perdurará en el tiempo. la variable guarda la ubicación del último yaml utilizado, de esta forma se sabe donde quedó el trabajo 

# Herramientas:

## El buscador de Plata

[Para ver el manual del buscador de plata ag haz clic aquí](manuales/ag.md)

## Broot:

### Un buscador difuso genérico:

El objetivo aquí es tener una función que pueda usar en Shell para brindarle una ruta.

Paso 1: crea un archivo ~/.config/broot/select.toml con este contenido:

``` toml

[[verbs]]
invocation = "ok"
key = "enter"
leave_broot = true
execution = ":print_path"
apply_to = "file"
]

```
*Paso 2: crea un atajo de algún tipo, por ejemplo usando ~/.bash_aliases

``` bash
alias bo="br --conf ~/.config/broot/select.toml"

```
Paso 3: luego puede usar broot como selector en otros comandos:

``` bash
echo $(bo)

# Ó
 
echo $(bo some/path)

```
Aquí, el archivo de configuración se usó para garantizar que pueda seleccionar un archivo con la tecla Intro.
Puede usar el mismo archivo de configuración para especificar colores para recordar que no está en un broot estándar.


## YAML:

Para procesar Yaml desde la linea de comandos, utilizaré yq.

*Un tuto Chevere de yq: [Procesando YAML en bash con yq](pages/Procesando-contenidoYAML-yq-www.baeldung.com.mhtml)

*Un tuto Chevere de yq: [Procesando YAML en bash con yq](file:///home/daniel/tron/programas/heuristic/pages/Procesando-contenidoYAML-yq-www.baeldung.com.mhtml)

  
*La pagina de github es: [https://github.com/mikefarah/yq](https://github.com/mikefarah/yq)
 
*La de manual es: [https://mikefarah.gitbook.io/yq/](https://mikefarah.gitbook.io/yq/)

## Bash:

### Encontrar la ruta relativa:

``` bash

realpath --relative-to="$file1" "$file2"

```
## Monolith 

### Página:

*   [monolith](https://github.com/Y2Z/monolith) 

### Comandos:

```bash

daniel@HungServ:~/tron/plugins/ComprimidosO.deb/chrome-linux$ ./chrome --headless --incognito --dump-dom file:///Ruta-sin-la-primera-barra.mhtml | monolith - -I -b https://github.com -o prueba6.html
```
