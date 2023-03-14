***************************************************************
d-feet
VER DBUS
https://wiki.gnome.org/action/show/Apps/DFeet?action=show&redirect=DFeet
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++





Especificación de bus D
https://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-routing-match-rules



/////////////////////////////////////////


BUSTLE   ????????????????????????????????

https://flathub.org/apps/details/org.freedesktop.Bustle

Bustle dibuja diagramas de secuencia de la actividad de D-Bus. Muestra las emisiones de señales, las llamadas a métodos y sus correspondientes retornos, con sellos de tiempo para cada evento individual y la duración de cada llamada a métodos. Esto puede ayudarlo a verificar el tráfico de D-Bus no deseado y determinar por qué su aplicación basada en D-Bus no funciona tan bien como desea. También proporciona estadísticas como frecuencias de señal y tiempos promedio de llamadas a métodos.



dbus-monitor //////////////////////////////////////



He estado usando dbus-monitor, que es realmente útil. Proporciona un --profilemodo, que proporciona un resumen rápido de todas las señales que rebotan.


https://dbus.freedesktop.org/doc/dbus-monitor.1.html

Nombre
dbus-monitor — sonda de depuración para imprimir mensajes de bus de mensajes

Sinopsis
dbus-monitor [ --sistema | --sesión | --dirección ADDRESS] [ --perfil | --supervisar | --pcap | --binario ] [ ]watch expressions

DESCRIPCIÓN
El comando dbus-monitor se usa para monitorear mensajes que pasan por un bus de mensajes D-Bus. Consulte https://www.freedesktop.org/wiki/Software/dbus/ para obtener más información sobre el panorama general.

Hay dos buses de mensajes bien conocidos: el bus de mensajes de todo el sistema (instalado en muchos sistemas como el servicio "messagebus") y el bus de mensajes por sesión de inicio de sesión de usuario (que se inicia cada vez que un usuario inicia sesión). Las opciones --system y --session dirigen a dbus-monitor para monitorear el sistema o los buses de sesión respectivamente. Si no se especifica ninguno, dbus-monitor supervisa el bus de sesión.

dbus-monitor tiene dos modos de salida de texto diferentes: el modo de monitoreo de estilo 'clásico' y el modo de creación de perfiles. El formato de creación de perfiles es un formato compacto con una sola línea por mensaje e información de tiempo de resolución de microsegundos. Las opciones --profile y --monitor seleccionan el formato de salida de perfilado y monitoreo respectivamente.

dbus-monitor también tiene dos modos de salida binaria. El modo binario, seleccionado por--binary, genera el flujo de mensajes binarios completo (sin el protocolo de enlace de autenticación inicial). El modo PCAP, seleccionado por--pcap, agrega un encabezado de archivo PCAP al comienzo de la salida y antepone un encabezado de mensaje PCAP a cada mensaje; esto produce un archivo binario que puede ser leído, por ejemplo, por Wireshark.

Si no se especifica ningún modo, dbus-monitor usa el formato de salida de monitoreo.

Para que dbus-monitor vea los mensajes que le interesan, debe especificar un conjunto de expresiones de observación como esperaría que se pasaran a la función dbus_bus_add_match .

La configuración del bus de mensajes puede impedir que dbus-monitor vea todos los mensajes, especialmente si ejecuta el monitor como un usuario no root.

OPCIONES
--system
Supervise el bus de mensajes del sistema.

--session
Supervise el bus de mensajes de la sesión. (Este es el valor predeterminado).

--address ADDRESS
Supervise un bus de mensajes arbitrario proporcionado en DIRECCIÓN.

--profile
Utilice el formato de salida de perfiles.

--monitor
Use el formato de salida de monitoreo. (Este es el valor predeterminado).

EJEMPLO
Aquí hay un ejemplo del uso de dbus-monitor para ver si el monitor de escritura gnome dice cosas



  dbus-monitor "tipo = 'señal', remitente = 'org.gnome.TypingMonitor', interfaz = 'org.gnome.TypingMonitor'"

AUTOR
dbus-monitor fue escrito por Philip Blundell. El modo de salida de perfiles fue agregado por Olli Salli.

INSECTOS
Envíe informes de errores a la lista de correo de D-Bus o al rastreador de errores, consulte https://www.freedesktop.org/wiki/Software/dbus/