#!/bin/sh
#plantilla YAML para marcadores de video
cat << EOF
nombreVideo: $nombreVideo
 - nombreMarcador: $nombreMarcador
   tiempoMarcador: $tiempoMarcador
EOF