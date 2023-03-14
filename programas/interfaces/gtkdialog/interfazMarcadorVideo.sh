export DIALOG='
<window title="LEGOS: Marcador de Video" name="MarcadorVideo">
<vbox border-width="5" border-color="FF0000" >
    <hbox>

        <text selectable="true">
            <label>Añadir Marcador en esta Posición del Video </label>
        </text>
        <button>
        <input file icon="bookmark_add"></input>
        <action>echo "bookmark_add"; exit 0</action>
        </button>
    </hbox>
    <hbox>

        <text selectable="true">
            <label>Borrar el último Marcador Creado</label>
        </text>
        <button>
        <input file icon="editdelete"></input>
        <action>echo editdelete</action>
        </button>
    </hbox>
    <hbox>

        <text selectable="true">
            <label>Abrir cuadro de diálogo: "Ir a Posición del Video"</label>
        </text>
        <button>
        <input file icon="filefind"></input>
        <action>echo filefind</action>
        </button>
    </hbox>


</vbox>

</window>
gtkdialog --program=DIALOG
