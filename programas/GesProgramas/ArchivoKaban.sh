snap-off () {

sudo systemctl stop snapd.service
sudo systemctl stop snapd.socket
sudo systemctl stop snapd.seeded.service
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service
killall mongod

    
}

snap-on () {

sudo systemctl enable snapd.service
sudo systemctl enable snapd.socket
sudo systemctl enable snapd.seeded.service 
sudo systemctl start snapd.service
sudo systemctl start snapd.socket
sudo systemctl start snapd.seeded.service

    
}

kaban-off () {
sudo snap stop wekan-gantt-gpl.caddy

sudo snap stop wekan-gantt-gpl.mongodb

sudo snap stop wekan-gantt-gpl.wekan
sudo snap stop wekan.wekan
snap-off   
}

kaban-on () {

snap-on
#sudo snap start wekan.wekan
sudo snap start wekan-gantt-gpl.wekan
}

snap-actualizar () {
sudo snap refresh
}

kaban-resp () {
pausa "seguro quieres respaldar?"
cd $plugins/kaban/respaldo
varres=respKaban_$(date +%d%b%Y%a%Ih%Mm%S)
mkdir $varres
cd $varres
 
sudo snap stop wekan.wekan
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/snap/wekan/current/lib/x86_64-linux-gnu
export PATH="$PATH:/snap/wekan/current/bin"
mongodump --port 27019
sudo snap get wekan > snap-settings.sh
chown $usuario:$usuario snap-settings.sh  
chmod +x snap-settings.sh
}

kaban-restaurar () {
cd /home/$usuario/tron/plugins/kaban/respaldo
echo
echo
ls
echo
echo "Ingrese el nombre de la carpeta de respaldo"
echo
read direccion
cd /home/$usuario/tron/plugins/kaban/respaldo/$direccion
sudo snap stop wekan.wekan
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/snap/wekan/current/lib/x86_64-linux-gnu
export PATH="$PATH:/snap/wekan/current/bin"
mongorestore --drop --port 27019
sudo snap start wekan.wekan
./snap-settings.sh
    
}
