#!/bin/bash
# Programa para hacer una instantanea de wekan-gantt-gpl
instantanea () { 
cd $plugins/kaban/respaldo
if [[ ! -d  $plugins/kaban/respaldo/respsnap  ]]; then
    mkdir  $plugins/kaban/respaldo/respsnap
fi

cd respsnap
varres=respSnap_$(date +%d%b%Y%a%Ih%Mm%S)
mkdir $varres
cd $varres
source ./i-d-wekan-gantt-gpl.sh
sudo snap stop wekan-gantt-gpl
sudo snap save
echo
snap saved
echo
echo "Ingrese el numero del snap a Exportar"
read numero
#mv -f kaban res-kaban
sudo snap export-snapshot $numero wekan-gantt-gpl 
#desintalarkaban

}
