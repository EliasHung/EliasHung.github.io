# Manual del Buscador de Plata

``` bash
Uso: ag [TIPO DE ARCHIVO] [OPCIONES] PATRÓN [RUTA]

   Busque recursivamente PATTERN en PATH.
   Como grep o ack, pero más rápido.

Ejemplo:
   ag -i foo /bar/

Opciones de salida:
      --ackmate Imprimir resultados en formato analizable AckMate
   -A --after [LINES] Imprime líneas después de la coincidencia (Predeterminado: 2)
   -B --before [LINES] Imprime líneas antes de la coincidencia (Predeterminado: 2)
      --[no]break Imprimir nuevas líneas entre coincidencias en diferentes archivos
                           (Habilitado por defecto)
   -c --count Sólo imprime el número de coincidencias en cada archivo.
                           (Esto a menudo difiere del número de líneas coincidentes)
      --[no]color Imprimir códigos de color en los resultados (Habilitado por defecto)
      --color-line-number Códigos de color para números de línea (Predeterminado: 1;33)
      --color-match Códigos de color para números de coincidencia de resultados (Predeterminado: 30;43)
      --color-path Códigos de color para nombres de ruta (Predeterminado: 1;32)
      --column Imprimir números de columna en los resultados
      --[no]filename Imprimir nombres de archivo (Habilitado a menos que busque un solo archivo)
   -H --[no]heading Imprime los nombres de archivo antes de las coincidencias de cada archivo
                           (Habilitado por defecto)
   -C --context [LINES] Imprime líneas antes y después de las coincidencias (Predeterminado: 2)
      --[no]group Igual que --[no]break --[no]heading
   -g --filename-pattern PATRÓN
                           Imprimir nombres de archivo que coincidan con PATRÓN
   -l --files-with-matches Solo imprime los nombres de archivo que contienen coincidencias
                           (no imprima las líneas coincidentes)
   -L --archivos-sin-coincidencias
                           Imprima solo nombres de archivo que no contengan coincidencias
      --print-all-files Imprime encabezados para todos los archivos buscados, incluso aquellos que
                           no contiene coincidencias
      --[no]numbers Imprimir números de línea. El valor predeterminado es omitir los números de línea
                           al buscar transmisiones
   -o --only-matching Imprime solo la parte coincidente de las líneas
      --print-long-lines Imprime coincidencias en líneas muy largas (Predeterminado: >2k caracteres)
      --passthrough Al buscar un flujo, imprime todas las líneas incluso si
                           no coinciden
      --silent Suprimir todos los mensajes de registro, incluidos los errores
      --stats Imprimir estadísticas (archivos escaneados, tiempo empleado, etc.)
      --stats-only Imprime estadísticas y nada más.
                           (Igual que --count al buscar en un solo archivo)
      --vimgrep Imprime resultados como los de vim :vimgrep /pattern/g
                           (informa cada coincidencia en la línea)
   -0 --null --print0 Nombres de archivo separados con nulo (para 'xargs -0')

Opciones de búsqueda:
   -a --all-types Buscar todos los archivos (no incluye archivos ocultos)
                           o patrones de archivos ignorados)
   -D --debug Depuración ridícula (probablemente no útil)
      --depth NUM Buscar hasta NUM directorios de profundidad (Predeterminado: 25)
   -f --follow Seguir enlaces simbólicos
   -F --fixed-strings Alias para --literal para compatibilidad con grep
   -G --file-search-regex PATRÓN Limita la búsqueda a nombres de archivo que coincidan con PATRÓN
      --hidden Buscar archivos ocultos (obedece a .*ignorar archivos)
   -i --ignore-case Coincide con mayúsculas y minúsculas de forma insensible
      --ignore PATRÓN Ignora archivos/directorios que coincidan con PATRÓN
                           (también se permiten nombres de archivos/directorios literales)
      --ignore-dir NOMBRE Alias para --ignore para compatibilidad con ack.
   -m --max-count NUM Omite el resto de un archivo después de NUM coincidencias (Predeterminado: 10,000)
      --one-device No siga enlaces a otros dispositivos.
   -p --path-to-ignore STRING
                           Usa el archivo .ignore en STRING
   -Q --literal No analiza PATRÓN como una expresión regular
  -s --case-sensitive  Coincide con mayúsculas y minúsculas
   -S --smart-case Coincide con mayúsculas y minúsculas a menos que PATTERN contenga
                           caracteres en mayúscula (Habilitado por defecto)
      --search-binary Buscar coincidencias en archivos binarios
   -t --all-text Busca todos los archivos de texto (no incluye archivos ocultos)
   -u --unrestricted Buscar todos los archivos (ignorar .ignorar, .gitignore, etc.;
                           busca archivos binarios y ocultos también)
   -U --skip-vcs-ignores Ignorar VCS ignorar archivos
                           (.gitignore, .hgignore; todavía obedecer .ignore)
  -v --invert-match invertir coincidencia
   -w --word-regexp Coincide solo con palabras completas
   -W --width NUM Truncar líneas de coincidencia después de NUM caracteres
   -z --search-zip Busca contenido de archivos comprimidos (p. ej., gzip)

Tipos de archivo:
La búsqueda se puede restringir a ciertos tipos de archivos. Ejemplo:
   ag --html aguja
   - Busca 'aguja' en archivos con sufijo .htm, .html, .shtml o .xhtml.

Para obtener una lista de los tipos de archivos admitidos, ejecute:
   ag --list-file-types

ag fue creado originalmente por Geoff Greer. Más información (y el último lanzamiento)
se puede encontrar en http://geoff.greer.fm/ag


```