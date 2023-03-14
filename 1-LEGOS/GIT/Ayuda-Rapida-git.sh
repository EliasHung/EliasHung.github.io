git

añadir
git add

instantanea con mensaje
git commit -m "mensaje"

instantarnea agregando los ultimos cambios y mensaje

git commit -am "mensaje"

ver mi llave ssh
eval $(ssh-agent -s)

crear la llave ssh para git
ssh-keygen -t ed25519 -C elias1hung@gmail.com

agregar la llave al servicio de llaves
ssh-add ~/.ssh/id_ed25519

la llave esta guardada en  
~/.ssh/

para ver la llave 
cat ~/.ssh/id_ed25519.pub

esa llave es la que se coloca en el sitio web de git

ver el log
git log

volver al commit anterior
git reset

regresar al ultimo commit
git reset --hard hash_de_commit

regresar a lo que sea que este en github
git reset --hard origin/master

cuantas ramas tengo y donde esta la cabeza
git branch
(el asterisco de la salida dice donde esta la cabeza)

crear una nueva rama de desarrollo
git checkout rombre_rama

fusionar rama cualquiera a actual
primero me ubico en la rama que va a ser afectada
git checkout actual
git merge cualquiera 

NOTA: despues de resolver los conflixtos solo hacer git commit -am "resolucion de conflictox"

bifurcar tener una copia local

GitHub Pages : GitHub Pages es una forma sencilla de publicar un sitio estático en la web. (Aprenderemos más adelante sobre sitios estáticos y dinámicos). Para hacer esto:
Cree un nuevo repositorio de GitHub.
Clone el repositorio y realice cambios localmente, asegurándose de incluir un index.htmlarchivo que será la página de destino de su sitio web.
Empuje esos cambios a GitHub.
Navegue a la página Configuración de su repositorio, desplácese hacia abajo hasta Páginas de GitHub y elija la rama maestra en el menú desplegable.
Desplácese hacia abajo hasta la parte Páginas de GitHub de la página de configuración, y después de unos minutos, debería ver una notificación que dice "Su sitio está publicado en: ..." ¡incluyendo una URL donde puede encontrar su sitio!



