instalarbasico () {
#d-feet es lector de Dbus, aspell-es es el diccionario español del sistema necesario para
# micro también se necesita en micro exuberant-ctags fzf  para saltar entre funciones
# python3.10-venv para los entornos virtuales de python
# instalé go (lenguaje) para instalar yq: procesador de YAML
apt install -y mousepad gcc make perl dpkg-dev build-essential debian-keyring dkms initramfs-tools unzip htop curl unrar apt-transport-https ufw build-essential zlib1g-dev wget libsqlite3-dev libbz2-dev gnupg software-properties-common unar rar bc figlet toilet kdialog debootstrap git synaptic lynx gjs zip evince  imagemagick-6.q16 exif android-tools-adb  clamav  node-shebang-command sqlite3 yad socat gparted  wget libsqlite3-dev libbz2-dev  unar rar  zstd  libjs-sphinxdoc micro ccze mpv vlc-bin dconf-editor minidlna min d-feet playerctl python-dev-is-python3 aspell-es exuberant-ctags fzf python3.10-venv xarchiver dialog inotify-tools


#instalando micro
echo "instalando micro"
curl https://getmic.ro | bash
#instalando plugins de micro
micro -plugin install snippets
micro -plugin install aspell
micro -plugin install filemanager
micro -plugin install jump
#micro -plugin install lsp

#d-feet es lector de Dbus aspell-es es el diccionario español del sistema lo necesita
# micro también

#DESINTALANDO SNAP QUE VIENE DE FABRICA
echo "DESINTALANDO SNAP QUE VIENE DE FABRICA"
apt purge -y snap     
}

instalarbrew () {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

instalarcode () {

    sudo apt update && sudo apt upgrade -y
    sudo apt install software-properties-common apt-transport-https wget
    sudo echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
    sudo apt update
    sudo apt upgrade -y; sudo apt install -y code       
} 

#instalando  sass para el CSS 
instalarSass (){
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install sass/sass/sass
}

instalardumpsesionchrome () {
    sudo curl -o /usr/bin/chrome-session-dump -L 'https://github.com/lemnos/chrome-session-dump/releases/download/v0.0.2/chrome-session-dump-osx' && sudo chmod 755 /usr/bin/chrome-session-dump  
}

instalarSpotify () {
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
}

#instalar buscador de plata
instalarAg (){
    # este no sirve en ubuntu 
    #brew install the_silver_searcher
    apt install -y silversearcher-ag
}


instalarservidorWeb () {
    apt install -y apache2
}

instalandoYq () {
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
    sudo add-apt-repository ppa:rmescandon/yq
    sudo apt update
    sudo apt install yq -y
    
}

# generador de cuadros de dialógo sencillos para terminal
# cuadros de diálogo cli
instalandoWhiptail () {
     brew install newt
}

instalarRclone () {
    sudo -v ; curl https://rclone.org/install.sh | sudo bash
}
#************REQUIERE TRON ********************************
instalarXnview () {
apt install -y "$plugins/ComprimidosO.deb/XnViewMP-linux-x64.deb"
}

instalarDocumentacion () {
# Servidor markdown
npm i -g markserv
#shdoc para documentar sh
cd ~/tron/plugins/shdoc
sudo make install    
}

instalarmonolith () {
  brew install monolith
}

instalandoEasybashgui () {
    inicio=$PWD
    cd $programas/interfaces/easybashgui
    sudo make install
    cd $inicio
 }

#***********************************
