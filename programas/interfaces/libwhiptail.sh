
whipmenu () {
# uso: $1 titulo $2 Mensaje $3 etiquetas los demás se explican en los nombres de variables 
    

    if [[ -z $6 ]] || [[ -z $4 ]] || [[ -z $5 ]]; then
        altura_dialogo=25
        ancho_dialogo=78
        altura_lista_del_menu=16
    else
        altura_dialogo=$4
        ancho_dialogo=$5
        altura_lista_del_menu=$6
    fi
    whiptail --title "$1" --menu "$2" $altura_dialogo $ancho_dialogo $altura_lista_del_menu $3 
    # "<-- Back" "Return to the main menu." \
    # "Add User" "Add a user to the system." \
    # "Modify User" "Modify an existing user." \
    # "List Users" "List all users on the system." \
    # "Add Group" "Add a user group to the system." \
    # "Modify Group" "Modify a group and its list of members." \
    # "List Groups" "List all groups on the system."

}

whipmensaje () {
titulo=$1
mensaje=$2
largo=$3
alto=$4

if [[ -z $3 ]] || [[ -z $4 ]]; then
        whiptail --title "$titulo" --msgbox "$mensaje." 8 78
else
        whiptail --title "$titulo" --msgbox "$mensaje." $alto $largo
fi
}
