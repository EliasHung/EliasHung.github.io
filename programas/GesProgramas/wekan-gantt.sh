#!/bin/bash
# programa para respaldar y recuperar wekan-gantt-gpl
# Programa para hacer una instantanea de wekan-gantt-gpl
# Instalar todo y Desintalar todo
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

respaldo-wekan-gantt-gpl () {
    pausa "seguro quieres respaldar?"
    cd $plugins/kaban/respaldo
    varres=respKaban_$(date +%d%b%Y%a%Ih%Mm%S)
    mkdir $varres
    cd $varres
    sudo snap stop wekan-gantt-gpl.wekan
    sudo export LC_ALL=C
    sudo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/snap/wekan-gantt-gpl/current/lib/x86_64-linux-gnu
    version=$(snap list | grep wekan | awk -F ' ' '{print $3}')
    mongo=$"/snap/wekan-gantt-gpl/$version/bin/mongo"
    export PATH="$PATH:/snap/wekan-gantt-gpl/$version/bin" 
    echo esperando 20 seg a que el servicio este a punto
    sleep 20 
    mongodump --port 27019   
    instantanea  
}

restaurar-wekan-gantt-gpl () {
    pausa "seguro quieres recuperar?"
    cd $plugins/kaban/respaldo
    ls
    echo
    echo "¿Cuál respaldo recuperar (Nombre de la carpeta)?"
    read carpeta
    cd $carpeta
    sudo snap stop wekan-gantt-gpl.wekan
    sudo export LC_ALL=C
    sudo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/snap/wekan-gantt-gpl/current/lib/x86_64-linux-gnu
    version=$(snap list | grep wekan | awk -F ' ' '{print $3}')
    mongo=$"/snap/wekan-gantt-gpl/$version/bin/mongo"
    export PATH="$PATH:/snap/wekan-gantt-gpl/$version/bin" 
    /snap/wekan-gantt-gpl/179/bin/mongorestore --drop --port 27019    
    sudo snap set wekan-gantt-gpl root-url='http://localhost'
    sudo snap set wekan-gantt-gpl port='3001'
    sudo snap start wekan-gantt-gpl.wekan    
}

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
   sudo rm -rf /snap; sudo rm -rf /var/snap;  sudo rm -rf /var/lib/snapd
}

instalarwekan-gantt-gpl () {
    #instalarsnap
    sudo snap install wekan-gantt-gpl
    sudo snap set wekan-gantt-gpl root-url='http://localhost'
    sudo snap set wekan-gantt-gpl port='3001'
    
    
}

menuKaban () { 
echo "Tron: $usuario, este programa "
echo "respalda y recuperar wekan-gantt-gpl"
echo " hace una instantanea de wekan-gantt-gpl
echo "" Instala todo WEKAN y Desintala WEKAN
echo
echo "Presione 0 para intalar snap."
echo "Presione 1 para desinstalar kaban y  snap."
echo "Presione 2 instalar kaban."
echo "Presione 3 para restaurar kaban."
echo "Presione 4 para respaldar kaban."
#echo "FUERA DE SERV. Presione 5 para solo sincronizar tron en el dispositivo.dsp."
#echo 'FUERA DE SERV. Presione 6 Dele que son pasteles--> Instalación casi "...sin preguntas."'
#echo "FUERA DE SERV. Presione 7 para desmontar todas las particiones."
#echo "FUERA DE SERV. Presione 8 para Solo debootstrap y chroot."
#echo "Presione 9 para Ejecutar PartiClon."

read frase
case $frase in
    0)
74
       instalarsnap
    ;;
    1)
        desintalarsnap
    ;;
    2)
        instalarwekan-gantt-gpl
    ;;
    3)
        restaurar-wekan-gantt-gpl
    ;;
    4)
        respaldo-wekan-gantt-gpl
    ;;
    5)
        

    ;;
    6)
    
    ;;
    7)

    ;;
    8)

    ;;
    9)
        
    ;;
esac

}

menuKaban

