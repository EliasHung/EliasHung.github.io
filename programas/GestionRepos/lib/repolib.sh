permisorepo () {
sudo chown -Rv _apt:root /home/$usuario/repo
sudo chown -Rv _apt:root /home/$usuario/repo2
sudo chmod -Rv 700 /home/$usuario/repo
sudo chown -R _apt:root /home/$usuario/repo
sudo chmod -Rv 700 /home/$usuario/repo2
sudo chown -R _apt:root /home/$usuario/repo2


}

# Nombre de paquete a descargar varios paquetes en comillas simples
descargarpaq () {
var=$1
apt install -y --download-only $var
apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances $var | grep "^\w" | sort -u)

}

escanearpaq () {
dpkg-scanpackages ./ > Packages && gzip -k -f Packages
}

repolocal () {
desea "Cambiar al repo local?"
si=$?
    if [ $si == 1 ]; then
        cat /etc/apt/sources.list > /etc/apt/RSPsources.list
        cat0=$?
        if [[ "$cat0" == 0 ]]; then
            rm /etc/apt/sources.list
	        #TODO: UNA BASE DE DATOS DE REPOS PARA QUE ALIMENTE AQUI
	        #puede ser un vector y un for 
	        #OJO EL PRIMERO SIEMPRE DEBE TENER DOS >> Y TODOS LOS DEMAS UNO
	        echo "deb [trusted=yes] file:/home/daniel/repo ./" > /etc/apt/sources.list
	        echo "deb [trusted=yes] file:/home/daniel/repo2 ./" >> /etc/apt/sources.list
            #apt install -y $var
	        #mv /etc/apt/RSPsources.list /etc/apt/sources.list
	        apt update
            return 0
        else
            echo "No se puede guardar el respaldo de sources.list"
            return 1
        fi
    fi
}

borrarpaqviejos () {

sudo dpkg-scanpackages $PWD 2>&1 >/dev/null | grep -Po '((\/.*?deb)(?=.*?repeat;))|used that.*?\K(\/.*deb)' | xargs rm
}

reponormal () {
    mv /etc/apt/RSPsources.list /etc/apt/sources.list
    apt update

}

instalar () {
preguntasalir "Pusiste comillas simples cuando son varios paquetes"
ejecutarcomoroot
var=$1
cd /home/$usuario/$repo/
echo "Ejecutando  apt-get download "
descargarpaq
if [[ $? -ne 0 ]]; then
	echo "ocurrió un error al descargar el paquete $var3 "
	return 1
fi
cuentafinal 2 "Ejecutando dpkg-scanpackages"
escanearpaq
apt update
apt install -y $var
}


copiarAptRepos  () {
montaje=$1
if [[ ! -d $montaje/home/repo ]]; then
    mkdir $montaje/home/repo
fi
if [[ ! -d $montaje/home/repo2 ]]; then
    mkdir $montaje/home/repo2
fi
echo '$montaje/home/repo/' es $montaje/home/repo/
echo '$montaje/home/repo2/' es $montaje/home/repo2/

rsync -azvhl -H --delete /home/$usuario/repo/ $montaje/home/repo/
rsync -azvhl -H --delete /home/$usuario/repo2/ $montaje/home/repo2/

}


