#!/bin/bash

#Programa creado por Elías Hung para Instalar y desintalar snap correctamente

instalarsnap () {
    
   sudo apt install -y snap
   sudo apt install -y snapd
   snap set system snapshots.automatic.retention=no
}

desintalarsnap () {
   sudo snap remove $(snap list | awk '!/^Name|^core/ {print $1}')
   sudo  apt -y remove snapd
   sudo  apt -y remove snap
   rm -rf ~/snap
   sudo rm -rf /snap
   sudo rm -rf /var/snap
   sudo rm -rf /var/lib/snapd
}
