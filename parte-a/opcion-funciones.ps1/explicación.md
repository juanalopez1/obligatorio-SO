## Nuestros scripts

Para cumplir con la consigna, hemos decidido crear varias funciones que acepten como parámetros el nombre del usuario al cual se aplicarán las operaciones definidas dentro de las funciones. En algunas funciones, también se pasan los nombres de las carpetas a crear. Hemos optado por esta metodología porque nos permitirá reutilizar el script fácilmente en el futuro para crear nuevos usuarios, respaldos y carpetas adicionales.

### funciones.ps1 
- create_user: Esta función crea un nuevo usuario con el nombre proporcionado como parámetro y lo añade al grupo "Usuarios".
- create_dir: Esta función crea un directorio en el escritorio del usuario especificado. Recibe como parámetros el nombre del usuario y el nombre del directorio a crear (en este caso, "Asientos" y "Comunicados"). Además, crea subdirectorios específicos dentro de estos directorios según lo  indicado en la consigna.
- do_backup: Esta función realiza una copia de seguridad de las carpetas creadas por create_dir en la raíz del disco.
- set_user_folder_permissions: Esta función ajusta los permisos del usuario para que solo tenga acceso a sus propias carpetas y pueda modificarlas.
- block_access_to_users: Esta función restringe el acceso del usuario a la raíz del disco.

### contaduria.ps1, recepcion.ps1 y relaciones_publicas.ps1
En estos scripts, se utiliza el archivo funciones.ps1 y se le proporcionan los parámetros necesarios para la ejecución de las funciones definidas. Estos archivos actúan como los "scripts ejecutables".
En los archivos de Contaduría y Relaciones Públicas se utilizan las cinco funciones presentes en funciones.ps1, mientras que en Recepción solo se usan tres, ya que en su consigna no se requiere realizar respaldos ni crear carpetas.

### soporte.ps1
Dos comandos, crear el usuario soporte, y agregarlo al grupo "Administradores"

### punto_5.ps1
Este script es diferente al resto ya que no esta estrechamente relacionado con los usuarios, sino con los procesos.
