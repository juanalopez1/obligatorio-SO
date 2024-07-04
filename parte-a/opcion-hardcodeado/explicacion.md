## Sobre nuestros scripts!

Después de haber lidiado con un intento fallido de crear una serie de funciones en un solo script y no haber encontrado el error, como equipo decidimos resolver la consigna utilizando scripts tradicionales. Simplemente escribimos los comandos necesarios para cumplir con el objetivo. Basándonos en las funciones, transcribimos para cada usuario las funciones utilizadas y "hardcodeamos" los nombres de los usuarios en lugar de pasarlos como parámetros, lo mismo con los directorios.

### Punto 1 __Contaduria__

Se deberá crear una **carpeta llamada “Asientos” en el Escritorio** de dicho usuario, en caso de no existir,
deberá ser creada. **Dentro de esta** deberán crearse tres carpetas adicionales: **“Diario”, “Semanal” y**
**“Mensual”.**
Deberá realizarse un **respaldo de la carpeta anterior,** cuya copia deberá guardarse en una carpeta llamada
Respaldo, la cual se encontrará **ubicada en la raíz del disco principal** del equipo, debiendo guardar dicho
respaldo en una **carpeta nombrada con la fecha** de realización de dicho respaldo (ej. 29FEB2024).
Este perfil **no** podrá realizar **instalaciones ni acceder al resto de las carpetas de otros usuarios,** por lo que
deberán configurarse los privilegios correspondientes.


Nuestro script cumple con todos los requisitos mencionados en la consigna, excepto en el apartado de no instalaciones, ya que decidimos realizar esta configuración manualmente.

### Punto 2 __Soporte__

Este perfil **no** tendrá ningún tipo de **restricciones,** debiendo realizar las configuraciones correspondientes
para asegurar el **acceso** de dicho usuario **a todas las carpetas** del equipo, así como la **ejecución e**
**instalación de cualquier aplicación.**

En nuestro script se ejecutan los comandos necesarios para otorgar a soporte privilegios completos de administrador.

### Punto 3 __Relaciones Públicas__

Se deberá **crear una carpeta llamada “Comunicados” en el Escritorio** de dicho usuario, en caso de no
existir, deberá ser creada. **Dentro de esta** deberán crearse dos carpetas adicionales: **“Semanal” y**
**“Mensual”.**
Deberá realizarse un **respaldo de la carpeta anterior,** cuya copia deberá guardarse en una carpeta llamada
Respaldo, la cual se encontrará **ubicada en la raíz del disco principal** del equipo, debiendo guardar dicho
respaldo en una carpeta **nombrada con la fecha** de realización de dicho respaldo (ej. 29FEB2024).
Este perfil **no** podrá realizar **instalaciones ni acceder al resto de las carpetas de otros usuarios,** por lo que
deberán configurarse los privilegios correspondientes.

Un script bastante parecido al primero, pero con cambios en los nombres utilizados.

### Punto 4 __Recepción__

Este perfil tendrá un uso restringido, pudiendo **guardar archivos solamente en** la estructura de **carpetas**
propias **del usuario** y **solamente podrá ejecutar los navegadores instalados** en dicho equipo (Firefox,
Chrome, Edge, Opera, etc)

Hemos adaptado los comandos de los scripts 1 y 3 para gestionar la restricción de acceso a las carpetas de otros usuarios. La configuración de los navegadores la hemos abordado de forma manual.

### Punto 5 __Control de procesos__

Deberá además crear un script que se ejecutara cada vez que inicie el SO, el cual **cada 60 minutos deberá**
**listar los 10 procesos que mas consuman CPU** en ese momento, debiendo **guardar** dicho **listado en** un
**archivo de texto,** generando **un archivo por día, el cual tendrá acumulado todos los listados de dicho día,**
**guardando** dicho **archivo en** una carpeta llamada **PROCESOS en la raíz del disco principal** del equipo.
En el caso de que el **usuario logueado** sea el de **SOPORTE,** dicho listado además **deberá mostrarse en**
**pantalla** (por consola o ventana).

Este script cumple con la consigna al crear una carpeta llamada "PROCESOS" en la raíz del disco principal si no existe, y generar un nombre de archivo basado en la fecha actual para asegurar un archivo por día que acumule los listados de procesos de ese día. La función GuardarProcesos obtiene los 10 procesos que más consumen CPU, formatea la información incluyendo la hora actual, y guarda el listado en el archivo correspondiente. Si el usuario logueado es "SOPORTE", también muestra el listado en pantalla. Finalmente, se programa una tarea para ejecutar esta función cada 60 minutos.



