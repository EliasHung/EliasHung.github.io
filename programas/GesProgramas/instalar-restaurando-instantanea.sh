#!/bin/bash
# Programa para  instalar wekan y restaurar desde la instantanea kaban
cd ~/tron/programas/GesProgramas
source ./i-d-snap.sh
source ./i-d-wekan-gantt-gpl.sh


instalarkaban
echo esperando 20 seg...
sleep 20
sudo snap set system snapshots.automatic.retention=no
sudo snap import-snapshot kaban
echo
snap saved
echo "Ingrese el número del snap a restaurar"
read numero
sudo snap restore "$numero"
sudo snap start wekan-gantt-gpl


