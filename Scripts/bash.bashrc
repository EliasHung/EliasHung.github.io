# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
#Proporciona cd automático al proporcionar una ruta en consola
shopt -s autocd
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *|*\ sudo\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi



#export LANG=es_ES.UTF-8

usuario=${SUDO_USER:-${USER}}
# OJO cuando se agrega con source se puede actualizar 
# con actz 




#DEFINIENDO FUNCIONES DE SISTEMA
if [ -f /home/$usuario/tron/plugins/bash/bashFunciones.sh ]; then
    . /home/$usuario/tron/plugins/bash/bashFunciones.sh
fi

# AGREGANDO FUNCIONES INDEPENDIENTES DE BASH
if [ -f /home/$usuario/tron/funciones/funciones.sh ]; then
   . /home/$usuario/tron/funciones/funciones.sh
fi

#OJO SI EXISTEN DOS FUNCIONES CON EL MISMO NOMBRE EN DOS SCRIPTS SOURCE,
#AGREGADOS AQUÍ: LA FUNCIÓN DEL ÚLTIMO SCRIPT AGREGADO SOBREESCRIBIRÁ
# A LA FUNCIÓN DEL PRIMERO.
#DEFINIENDO VARIABLES
if [ -f /home/$usuario/tron/plugins/bash/bashVariables.sh ]; then
	source /home/$usuario/tron/plugins/bash/bashVariables.sh

fi

##AGREGANDO ALIAS

if [ -f /home/$usuario/tron/plugins/bash/alias.sh ]; then
    . /home/$usuario/tron/plugins/bash/alias.sh
fi


# AGREGANDO LAS NUEVAS FUNCIONES DE ALTO NIVEL
if [ -f /home/$usuario/tron/Scripts/AltoNivel.sh ]; then
   . /home/$usuario/tron/Scripts/AltoNivel.sh

fi
  
# AGREGANDO LAS NUEVAS FUNCIONES DE BAJO NIVEL
if [ -f /home/$usuario/tron/Scripts/BajoNivel.sh ]; then
   . /home/$usuario/tron/Scripts/BajoNivel.sh

fi
# Agregando funcion br para broot
#source /home/$usuario/.config/broot/launcher/bash/br
## AGREGANDO COLOR
#if [ -f /home/$usuario/tron/plugins/bash/bash_color.sh ]; then
#   . /home/$usuario/tron/plugins/bash/bash_color.sh

#fi
#AGREGANDO RUTAS A BASH

#export PATH="/etc/scripts/:$PATH"
#export PATH="$tron/funciones/:$PATH"
#export PATH="$tron/install/:$PATH"
#export PATH="$tron/Scripts/:$PATH"
#export PATH="$tron/plugins/admScripts/:$PATH"
#export PATH="$tron/plugins/gedit:$PATH"
export PATH="$plugins/node/node-v18.13.0-linux-x64/bin:$PATH"
#export PATH="$plugins/kitty/kitty-0.26.5-x86_64/bin:$PATH"
#export PATH="/snap/bin:$PATH"
export PATH="$plugins/broot:$PATH"
# VAriables de broot
export EDITOR=$(which micro)
export SHELL="/bin/bash"
export KITTY_CONFIG_DIRECTORY="$config/kitty"
export PATH="/home/$usuario/.local/kitty.app/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
## Probando  el autocompletado en bash
#if [ -f /etc/bashcompletion ]; then
#. /etc/bashcompletion
#fi

#Guardar el historal de todas las sesiones
#shopt -s histappend
#export PROMPT_COMMAND="history -a; $PROMPT_COMMAND" 

## Manda al historial EN TIEMPO REAL
#PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
##tamaño de comandos que se pueden mostrar y tamaño de el historial
#HISTSIZE=30000
#HISTFILESIZE=40000

# Poniendo fecha a los comandos 
#HISTTIMEFORMAT="%F %T: "
#if (( $EUID == 0 )); then
#        source /root/.config/broot/launcher/bash/br
#elif (( $EUID != 0 )); then
#        source home/$usuario/.config/broot/launcher/bash/br
#fi
