
# ALIAS DEL SISTEMA
# CREADOS POR ELIAS HUNG
# elprofesorverdad@gmail.com
alias actualizable="apt list --upgradable"
alias actz='source /home/.bashrc; echo "TRON: $usuario,  información en disco actualizada."'
alias adb-iniciar='adb start-server'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias aliased='funAliased'
alias aliaslk='alias | grep $1'
alias alias-otro='fnOtroAlias'
alias AltoNivel="micro $scripts/AltoNivel.sh " 
alias antivirus-actualizar='systemctl stop clamav-daemon.service && freshclam'
alias antivirus-comenzar='/etc/init.d/clamav-daemon start'
alias antivirus-parar='systemctl stop clamav-daemon.service || systemctl stop clamav-freshclam.service || systemctl disable clamav-daemon.service || systemctl disable clamav-freshclam.service'
alias apagar-monitor='xset dpms force off'
alias BajoNivel="micro $scripts/BajoNivel.sh "
alias bashed="sudo micro $tronbash/bash.bashrc; sudo su; installBash; echo; echo AVISO: USUARIO ROOT"
alias box-editar='editar /home/daniel/.config/openbox/autostart'
alias buscark='funbuscar'
alias buscar='mlocate -ipt'
alias buscar-txt='funbuscartexto'
alias centro-d='sudo systemctl disable jellyfin.service'
alias centro-e='sudo systemctl enable jellyfin.service'
alias centro-start='sudo systemctl start jellyfin.service; sudo systemctl status jellyfin.service'
alias centro-status='sudo systemctl status jellyfin.service'
alias centro-stop='sudo systemctl stop jellyfin.service; sudo systemctl status jellyfin.service'
alias chmod='chmod -v'
alias chown='chown -v'
alias chuletaed='chuletaed'
alias chuleta='editar /home/$usuariol/respaldo/sincronizados/ComandosLinux.sh'
alias chuleta-mysql='editar /media/daniel/RespSdb1/sincronizados/chuleta_mysql.sql'
alias class='ng-star-inserted'
alias climaen="curl wttr.in/"
alias clonezilla="/usr/sbin/clonezilla"
alias cls='clear'
alias consola='sudo gnome-terminal; sudo mount /dev/sdb6 /media/daniel/RespSdb1'
alias cp='cp -v'
alias crom='/usr/bin/google-chrome-stable %U'
alias ctorr='crom  https://rarbgdata.org/index80.php https://torrentgalaxy.to https://pelistorrent.org https://pediatorrent.com https://yestorrent.org https://pelispanda.com https://mitorrent.me https://yts.mx https://1337x.to'
alias cualesmiiplocal="hostname -i"
alias depurar="echo 'set -x; set -v; set -e y para sintaxix set -n'"
alias discos-espacio='df -h'
alias discos='gnome-disks'
alias discos-montar='montarDiscos'
alias discos-mostrar='lsblk -fml'
alias dlna-conf="sudo micro /home/$usuario/tron/config/minidlna/minidlna.conf"
alias dlna-off="sudo service minidlna stop; sudo umount -v  /home/daniel/Escritorio/s/sdb5"
alias dlna-on="sudo mkdir /media/daniel/medios;sudo mount -v /dev/sdb5 /media/daniel/medios ; sudo mount --bind -v /media/daniel/medios/medios /home/daniel/Escritorio/s/sdb5; sudo service minidlna start; dlna-status"
alias dlna-reset="sudo service minidlna force-reload; sudo service minidlna restart"
alias dlna-status="sudo service minidlna status"
alias dondeestamongo="netstat -plant | grep mongo"
alias dondeesta="which"
alias dondeestoy="lsblk"
alias dw='fire https://www.dw.com/es/tv-en-vivo/s-100837'
alias editaraudio="$plugins/AppImage/audacity-linux-3.2.3-x64.AppImage"
alias editar='micro'
alias egrep='egrep --color=auto'
alias entorno-virtual-activar='fnActivar'
alias entorno-virtual='python3.10 -m venv'
alias escribir='Funquedonde2'
alias escritorio-configuracion="xfconf-query -l; xfce4-settings-editor; dconf-editor "
alias espacio='du -sH'
alias espacio-libre='df -H'
alias espacio-recursivo='du -Ha '
alias espacio-recursivo-total='du -aH --total'
alias espacio-total='du -sH --total'
alias fgrep='fgrep --color=auto'
alias fire='/home/daniel/tron/plugins/navegadores/firefox/firefox'
alias firewall-abrir="sudo ufw allow"
alias firewall-cerrar-entrantes="sudo ufw default deny incoming"
alias firewall-off="sudo ufw disable"
alias firewall-on="sudo ufw enable"
alias firewall-permitir-ip-puerto="echo 'sudo ufw allow from 203.0.113.4 to any port 22'"
alias firewall-permitir-ip="sudo ufw allow from"
alias firewall-permitir-salientes="sudo ufw default allow outgoing"
alias funcionunasolalinea="echo 'alias remendarinstall=\"remienda() { apt --fix-broken install $1 ; }; remienda\"'"
alias funed='funEd'
alias google-consulta=' https://www.google.com/search?q='
alias grep='grep --color=auto'
alias hardware='funHard'
alias hig='history -a ; echo la historia ha sido contada...'
alias ibuscar='fire -search'
alias imagen-convertir-fondo='ImgConvFondoCompu'
alias imagen-info='imagenInformacion'
alias instalar-modulo-local='python3.10 -m pip install -e .'
alias interfaz-activar='systemctl set-default graphical.target'
alias interfaz-desactivar='systemctl set-default multi-user.target'
alias interfaz-detener='systemctl stop graphical.target ; systemctl isolate multi-user.target'
alias interfaz-iniciar='systemctl start graphical.target'
alias interfaz-parar='systemctl stop graphical.target'
alias jellyfin='sudo systemctl start jellyfin.service; fire http://localhost:8096'
alias kaban="crom http://localhost:3001/"
alias la='ls -A'
alias leemeinstalar="micro $programas/Mudanza/LEEME.txt"
alias letras1='figlet -f 3d -d /home/daniel/tron/plugins/figlet/figlet-fonts/'
alias letras2='figlet -f Basic -d /home/daniel/tron/plugins/figlet/figlet-fonts/'
alias lik='aliaslike'
alias lis='dolphin /home/daniel/respaldo/LISTAS/'
alias llave='sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys'
alias ll='ls -alF'
alias l='ls -CF'
alias lsb="lsbonito"
alias lsbonito="br -sdp"
alias ls='ls --color=auto'
alias mata='echo Matando al desgraciado... ; echo matando a ese cño de su pepa.... ; fnmata3 ; echo muerto ese hijo de p...'
alias mem='killall mysqld;sincro-off; sudo systemctl stop jellyfin.service sudo su; dlna-off'
alias mimusica="nvlc $musica"
alias miniaturas='editar /etc/xdg/tumbler/tumbler.rc'
alias mio='chown -R -c -H -h -L $usuario:$usuario $PWD/*'
alias montar-respaldo='mkdir /media/daniel/RespSdb1; mount /dev/sdb5 /media/daniel/RespSdb1'
alias mount='mount -v'
alias mudanza="micro $programas/Mudanza/MudarSisDeExternoAHostDesdeHost.sh"
alias musica-alegre='firefoxdev2 https://www.youtube.com/playlist?list=PLB7Gv154MOxrRsF5joeucAewsUWbFyi6B'
alias mv='mv -v'
alias noip-iniciar='./sincronizarNoip.sh'
alias notas='editar /home/daniel//home/daniel/tron/zdemas/Notas.py'
alias notased='notased'
alias off='systemctl stop jellyfin.service; shutdown -r now'
alias p755='chmod -R -c 755 *'
alias papelera-borrar='locate --null .Trash | xargs -0 rm -v -r'
alias paquetesrotos="remienda() { apt --fix-broken install $1 ; }; remienda"
alias pdf='evince'
alias play='mpv --config-dir=/home/daniel/tron/plugins/mpv/'
alias proyecto1='cd /home/daniel/Desktop; source Proyecto1/bin/activate; cd '
alias proyecto='echo --- TODO ---; echo; cat //home/daniel/tron/zdemas/TODO.md; thunar /PYTHON/KIVI/; thunar /home/daniel/tron/biblioteca/Kivy/'
alias proyecto-todo='code; thunar /PYTHON/KIVI/; thunar /home/daniel/tron/biblioteca/KIVY_BIBLIO; echo --- TODO ---; echo; echo; cat //home/daniel/tron/zdemas/TODO.md | more'
alias pycharm='/home/daniel/.local/share/JetBrains/Toolbox/apps/PyCharm-C/ch-0/221.5591.52/bin/pycharm.sh'
alias py='python3.10'
alias queinstalesnap="snap-on; snap changes; ls -l /snap/bin; ls -l /var/lib/snapd/snaps"
alias queinstaleubuntu="micro $programas/Mudanza/quinetaleenubu18sencillo.sh"
alias quekerneltengo="uname -srm"
alias quienpuerto="sudo ss -tunelp | grep "
alias radioid='ve.onda1045'
alias radioimg='//us0-cdn.onlineradiobox.com/img/l/3/31463.v12.png'
alias radio-lamega='nvlc https://playerservices.streamtheworld.com/api/livestream-redirect/LA_MEGA_BOGAAC.aac?dist=rcn-web'
alias radio-latina='nvlc https://centova.intervenhosting.net/proxy/latina101/stream'
alias radio-mundial-puntofijo='nvlc http://streamingned.com:7074/'
alias radio="nvlc /home/$usuario/tron/plugins/radio/radio.xspf"
alias radio-ok='nvlc http://server6.globalhostla.com:9080/stream'
alias radio-onda='nvlc https://onlineradiobox.com/json/ve/onda1045/play?platform=web'
alias radio-rumbera='nvlc https://sonic01.instainternet.com/8290/stream'
alias radio-rumbos='nvlc http://cp2.lorini.net:19020/stream'
alias radio-sabrosa='nvlc https://acp4-cdn.lorini.net/proxy/28017?mp=/stream'
alias radio-show-valencia='nvlc https://server6.globalhostla.com:2000/tunein/sc_show2/stream/pls'
alias respaldo="sudo -s /home/$usuario/tron/programas/partitionclon/principal.sh $usuario"
alias rm='rm -v'
alias salida="echo $?" 
alias servicio-editar='editar /etc/systemd/system/'
alias sincro='funSincronizar'
alias sincro-off='killall syncthing'
alias ssh-reiniciar="sudo systemctl restart ssh"
alias s="sudo su"
alias streamtype='mp3'
alias tera='fire https://www.terabox.com/main?category=all'
alias todoed='funTodoed'
alias todo='nano //home/daniel/tron/zdemas/TODO.md'
alias torr='fire -url https://rarbgdata.org/index80.php https://thepiratebay.org/index.html https://torrentgalaxy.to https://pelistorrent.org https://pediatorrent.com https://yestorrent.org https://pelispanda.com https://mitorrent.me https://yts.mx https://1337x.to https://www.limetorrents.lol'
alias tra='transmission-gtk %U'
alias tron="/bin/bash $tron/tron/tron"
alias type='audio/aac'
alias ultimaver-vlc="fire https://github.com/cmatomic/VLCplayer-AppImage/releases/latest"
alias umount='umount -v'
alias updatedbed='editar /etc/updatedb.conf'
alias vared='FunVared'
alias var='FunVariables'
alias vertabla='fnvertabla'
alias vlc="cd ~/tron/plugins/AppImage; ./VLC_media_player-3.0.11.1-x86_64.AppImage"
alias vol="alsamixer"
alias web-a-pdf='wkhtmltopdf'
alias wifi='echo Iniciando WIFI HUNG && service network-manager restart  && sleep 10 && echo red reiniciada && sleep 3 && nmtui connect'
alias xcd='cd "$(cd /home/daniel/tron/plugins/xeplr; ./xplr --print-pwd-as-result)"'
alias xplr="cd /home/daniel/tron/plugins/xeplr; ./xplr"
