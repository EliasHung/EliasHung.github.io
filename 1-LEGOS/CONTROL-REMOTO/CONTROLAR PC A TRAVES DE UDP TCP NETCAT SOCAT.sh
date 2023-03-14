CONTROLAR PC A TRAVES DE UDP TCP NETCAT SOCAT

https://unix.stackexchange.com/questions/299677/controling-a-pc-via-tcp-udp-commands-necat-socat

Este es un uso clásico de netcat. Pero esto es unix.SEasí que mi respuesta estará completamente en Unix.

Nota: netcattiene diferentes nombres en diferentes distribuciones:

netcat: alias para ncen algunas distribuciones
nc: GNU netcat en linux o BSD netcat en *BSD
ncat: Nmap netcat, consistente en la mayoría de los sistemas
Opciones entre diferentes versiones de netcatvarían, señalaré dónde las diferentes versiones pueden comportarse de manera diferente. Además, recomiendo enfáticamente instalar la versión nmap de netcat ( ncat) ya que sus opciones de línea de comando son consistentes en diferentes sistemas.

Lo ncatusaré como el nombre de netcat a través de la respuesta.

TCP
Para usar TCP para controlar una máquina netcat, tiene dos opciones: usar una canalización con nombre (que funciona con todas las versiones de netcat) y usar -e(que solo existe en la versión de Linux o, más exactamente, -een *BSD hace algo completamente diferente) .

En el lado del servidor , debe realizar:

mkfifo pinkie
ncat -kl 0.0.0.0 4096 <pinkie | /bin/sh >pinkie
Donde: 0.0.0.0es el marcador de posición para "todas las interfaces", use una IP específica para limitarlo a una interfaz específica; -les escuchar y -kmantener abierto (para no terminar después de una sola conexión).

Otra opción (en linux/ncat) es usar:

ncat -kl 0.0.0.0 4096 -e /bin/sh
Para lograr el mismo resultado.

En el lado del cliente , puede usar su aplicación o simplemente realizar:

ncat <server ip> 4096
Y usted tiene el control del shell en el servidor y puede enviar comandos.

UDP
UDP es similar pero tiene algunas limitaciones. No puede usar -kel protocolo UDP sin -e, por lo tanto, necesita usar linux/ncat para lograr un socket reutilizable.

En el lado del servidor haces:

ncat -ukl 0.0.0.0 4096 -e /bin/sh
Y en el lado del cliente (o desde su aplicación):

ncat -u <server ip> 4096
Y una vez más tienes un caparazón que funciona.





**************************************

usos SOCAT
https://www.cyberciti.biz/faq/linux-unix-tcp-port-forwarding/

Para redirigir todas las conexiones del puerto 80 a la ip 202.54.1.5, ingrese:
# socat TCP-LISTEN:80,fork TCP:202.54.1.5:80

Todas las conexiones TCP4 al puerto 80 se redirigirán a 202.54.1.5. Esto es como netcat. Puede finalizar la conexión presionando [CTRL+C], es decir, ^C.

Conectarse al servidor SSH remoto
Puede conectarse al servidor ssh remoto llamado server1 y usar pty para la comunicación entre socat y ssh, hace que ssh controle tty (ctty) y haga que este pty sea el propietario de un nuevo grupo de procesos (setsid), por lo que ssh acepta la contraseña de socat.
$ (sleep 5; echo YOURSSHPASSWORDHERE; sleep 5; echo date; sleep 1) |socat - EXEC:'ssh -l userName server1.nixcraft.net.in',pty,setsid,ctty

