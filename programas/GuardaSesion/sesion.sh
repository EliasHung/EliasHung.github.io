#!/bin/bash
#Programa creado por Elías Hung para guardar las Gestionar Sesiones de Escritorio



#Guarda las ventanas abiertas en una variable.
GuardaVentanas () {
   var="$(lsof +D "$tron")"
   echo "$var"
}
GuardaVentanas
