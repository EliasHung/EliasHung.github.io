#!/bin/bash
instalarWekan () {
sudo apt install -y snap
sudo apt install -y snapd
sudo snap install wekan
}

wekan-restaurar () {


cd /home/$usuario/tron/plugins/kaban/respaldo/ultimo
sudo snap stop wekan.wekan
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/snap/wekan/current/lib/x86_64-linux-gnu
export PATH="$PATH:/snap/wekan/current/bin"
mongorestore --drop --port 27019

sudo snap set wekan port='3001'
sudo snap set wekan root-url='localhost'
sudo snap start wekan.wekan
} 

wekan-resp () {
pausa "seguro quieres respaldar?"
dia=`date +"%d-%m-%Y"`
hora=`date +"%r"`
sep="_"
carpeta="$dia$sep$hora"
mkdir /home/$usuario/tron/plugins/kaban/respaldo/$carpeta
cd /home/$usuario/tron/plugins/kaban/respaldo/$carpeta
sudo snap stop wekan.wekan
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/snap/wekan/current/lib/x86_64-linux-gnu
export PATH="$PATH:/snap/wekan/current/bin"
mongodump --port 27019
sudo snap get wekan > snap-settings.sh
chown $usuario:$usuario snap-settings.sh  
chmod +x snap-settings.sh
}
