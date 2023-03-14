#!/bin/bash
# Programa creado para instalar-desintalar snap y wekan-gantt sin instalar respaldo

source ./i-d-snap.sh
instalarwekan-gantt-gpl () {
    #instalarsnap
    sudo snap install wekan-gantt-gpl
    sudo snap set wekan-gantt-gpl root-url='http://localhost'
    sudo snap set wekan-gantt-gpl port='3001'
    
    
}

desintalarwekan-gantt-gpl () {
    sudo snap remove wekan-gantt-gpl
    desintalarsnap
} 

instalarkaban () {
   instalarwekan-gantt-gpl 
}


desintalarkaban () {
   desintalarwekan-gantt-gpl 
}
