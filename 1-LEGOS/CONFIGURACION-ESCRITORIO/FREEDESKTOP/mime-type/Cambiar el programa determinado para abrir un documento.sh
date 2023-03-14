Cambiar el programa determinado para abrir un documento
por su mime

 OJO para  listar los tipos mime de los documentos de una carpeta, ubicandose dentro de la carpeta:
 for file in ./*; do xdg-mime query filetype "$file"; done

para saber el nombre del .desktop de chrome:
ls /usr/share/applications | less

Aca estan las parejas mime:
 dela forma tipo/mime=aplicacion.desktop, en :
sudo micro /usr/share/applications/defaults.list
hay que agregar el tipo:
application/x-mimearchive=google-chrome.desktop

asi google chrome abre entonces los mhtml

