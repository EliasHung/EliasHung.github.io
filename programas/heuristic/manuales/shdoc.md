# shdoc 

shdoc es un generador de documentación para bash/zsh/sh para generar documentación API en Markdown a partir de 
la fuente de scripts de shell. 

shdoc analiza [anotaciones](#características) al principio de un archivo determinado y junto con las 
definiciones de funciones, y crea un archivo de descuento con documentación lista para usar. 

## Índice 

* [Ejemplo](#ejemplo) 
* [Anotaciones](#anotaciones) 
* [Uso](#uso) 
* [Instalación](#instalación) 
* [Más ejemplos](#ejemplos) 
* [Licencia](# licencia) 

## Ejemplo 

<table border="0"> 
 <tr> 
    <td style="vertical-align: top"> 

Genere documentación con el siguiente comando: 
~~~bash
$ shdoc < lib.sh > doc.md 
~~~ 

_Source_ [examples/readme-example.sh](examples/readme-example.sh)<br /> 
_Output_: [examples/readme-example.md](examples/ readme-example.md)<br/><br/> 
~~~bash 
#!/bin/bash 
# @file libexample 
# @brief Una biblioteca que resuelve algunos problemas comunes. 
# @description 
# El proyecto resuelve muchos problemas: 
# * a 
# * b 
# * c 
# * etc 

# @description Mi súper función. 
# No es seguro para subprocesos. 
# 
# @example 
# echo "test: $(say-hello World)" 
# 
# @arg $1 cadena Un valor para imprimir 
# 
# @exitcode 0 Si tiene éxito.
# @exitcode 1 Si pasa una cadena vacía. 
# 
# @ver validar() 
saludar() { 
    si [[ ! "$1" ]]; luego 
        devuelve 1; 
    fi 

    echo "Hola $1" 
} 
~~~ 


</td> 
<td> 

~~~markdown 
# libexample 

Una biblioteca que resuelve algunos problemas comunes. 

## Descripción general 

El proyecto resuelve muchos problemas: 
* a 
* b 
* c 
* etc. 

## Índice 

* [saluda](#saluda) 

### saluda 

Mi súper función. 
No es seguro para subprocesos. 

#### Ejemplo 

```bash 
echo "test: $(say-hello World)" 
``` 

#### Argumentos

* **$1** (cadena): Un valor para imprimir 

#### Códigos de salida 

* **0**: Si tiene éxito. 
* **1**: si pasa una cadena vacía. 

#### Ver también 

* [validate()](#validate) 
~~~ 

</td> 
</tr></table> 


## Características 

### `@name` 

Un nombre del proyecto, usado como título del doc. Se puede especificar una vez al principio del 
archivo. 

**Ejemplo** 

```bash 
#!/bin/bash 
# @name MyLibrary 
``` 

### `@file` 

Idéntico a [@name](#name). 

### `@brief` 

Una breve línea sobre el proyecto. Se puede especificar una vez al principio del archivo.<br> 

**Ejemplo** 
```bash 
#!/bin/bash
# @brief Una biblioteca para resolver algunos problemas. 
``` 

### `@description` 

Una descripción de varias líneas del proyecto/sección/función. 
* Se puede especificar una vez para todo el archivo al principio del archivo. 
* Se puede especificar una vez para una sección del archivo. Ver [@sección](#sección). 
* Se puede especificar una vez encima de una definición de función. 

**Ejemplo** 
```bash 
#!/bin/bash 
# @description Una descripción larga de la biblioteca. 
# Segunda línea de la descripción del proyecto. 

# @description Mi súper función. 
# Segunda línea de la descripción de mi súper función. 
función super() { 
    ... 
} 
``` 

### `@sección`

El nombre de una sección del archivo. Se puede utilizar para agrupar funciones. 

**Ejemplo** 
```bash 
# @section Funciones de mis utilidades 
# @description Las siguientes funciones se pueden usar para resolver problemas. 
``` 

### `@example` 

Un ejemplo de varias líneas del uso de la función. Solo se puede especificar junto con la definición de la función. 

**Ejemplo** 
```bash 
# @ejemplo 
# echo "test: $(say-hello World)" 
say-hello() { 
    ... 
} 
``` 

### `@arg` 

Una descripción de un argumento se espera que se pase al llamar a la función. 
Se puede especificar varias veces para describir cualquier número de argumentos. 

**Ejemplo** 
```bash
# @description Saluda a una persona determinada. 
# @arg $1 cadena El nombre de una persona. 
# @arg $2 string Prioridad del mensaje. 
say-hello() { 
    ... 
} 
``` 

### `@noargs` 

Una nota de que la función no espera que se pase ningún argumento. 

**Ejemplo** 
```bash 
# @description Dice 'hola mundo'. 
# @noargs 
say-hello-world() { 
    ... 
} 
``` 

### `@set` 

Una descripción de una variable global que se establece al llamar a la función. 
Se puede especificar varias veces para describir cualquier número de variables 

**Ejemplo** 
```bash 
# @description Establece hola en la variable RESPONDER
# @set REPLY string Mensaje de saludo. 
set-hello() { 
    ... 
} 
``` 

### `@exitcode` 

Describe un código de salida esperado de la función. 
Se puede especificar varias veces para describir todos los códigos de salida posibles y sus condiciones. 

**Ejemplo** 
```bash 
# @description Dice 'hola mundo'. 
# @exitcode 0 Si tiene éxito. 
# @exitcode 1 Si el mundo se ha ido. 
say-hello-world() { 
    ... 
} 
``` 

### `@stdin` 

La entrada esperada para la llamada de función desde `stdin` (generalmente la terminal o la línea de comando) 

**Ejemplo** 
```bash 
# @description Pregunta el nombre.
# @stdin El nombre de usuario del terminal/línea de comando. 
say-hello-world() { 
    ... 
} 
``` 

### `@stdout` 

Una salida esperada de la llamada a la función. 

**Ejemplo** 
```bash 
# @description Dice 'hola mundo'. 
# @stdout Una ruta a un archivo temporal con el mensaje. 
say-hello-world() { 
    ... 
} 
``` 

### `@stderr` 

Una salida esperada de la llamada de función en `/dev/stderr`. 

**Ejemplo** 
```bash 
# @description Dice 'hola mundo'. 
# @stderr Un mensaje de error cuando el mundo no está disponible. 
decir-hola-mundo() { 
    ... 
} 
``` 

### `@ver`

Cree un enlace en la función dada en la sección "Ver también". 

**Ejemplo** 
```bash 
# @see say-hello 
# @see text with [markdown link](./other-file#other-function) 
say-hello-world() { 
    ... 
} 
``` 

### `@internal` 

Cuando desee omitir la generación de documentación para una función en particular, puede especificar esta 
etiqueta `@internal`. 
Le permite tener el mismo estilo de comentarios de documentos en todo el script y mantener las 
funciones internas ocultas para los usuarios. 

**Ejemplo** 
```bash 
# @internal 
show-msg() { 
    ... 
} 
``` 

## Uso

shdoc no tiene argumentos y espera un script de shell con comentarios en stdin y producirá una reducción como stdout. 

```bash 
$ shdoc < your-shell-script.sh > doc.md 
``` 

## Instalación 

### Arch Linux 

Los usuarios de Arch Linux pueden instalar shdoc usando el paquete en AUR: [shdoc-git](https:// aur.archlinux.org/packages/shdoc-git) 

### Usando Git 

NOTA: shdoc requiere gawk: `apt-get install gawk` 

```bash 
git clone --recursive https://github.com/reconquest/shdoc 
cd shdoc 
sudo make install 
``` 

### Otros 

Desafortunadamente, no hay paquetes de shdoc para otras distribuciones, pero estamos buscando contribuciones. 

## Ejemplos 

Consulte la documentación de ejemplo en:

* [pruebas.sh](https://github.com/reconquest/tests.sh/blob/master/REFERENCE.md) 
* [coproc.bash](https://github.com/reconquest/coproc.bash/ blob/master/REFERENCIA.md) 

# LICENCIA 

MIT