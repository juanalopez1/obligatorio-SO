# Puntos 2 y 5

## Punto 2 *Soporte*

Este perfil ```no``` tendrá ningún tipo de ```restricciones,``` debiendo realizar las configuraciones correspondientes
para asegurar el ```acceso``` de dicho usuario ```a todas las carpetas``` del equipo, así como la ```ejecución e instalación de cualquier aplicación.```

En nuestro script creamos una función con los comandos necesarios para crear un usuario administrador. El nombre del mismo será pasado por parámetro. 

## Punto 5 *Control de procesos*

Deberá además crear un script que se ejecutara cada vez que inicie el SO, el cual ```cada 60 minutos deberá```
```listar los 10 procesos que mas consuman CPU``` en ese momento, debiendo ```guardar``` dicho ```listado en un archivo de texto,``` generando ```un archivo por día, el cual tendrá acumulado todos los listados de dicho día, guardando``` dicho ```archivo en``` una carpeta llamada PROCESOS en la raíz del disco principal``` del equipo.
En el caso de que el ```usuario logueado``` sea el de ```SOPORTE,``` dicho listado además ```deberá mostrarse en pantalla``` (por consola o ventana).

El script control_de_procesos cumple con la consigna al crear una carpeta llamada "PROCESOS" en la raíz del disco principal si no existe, y generar un nombre de archivo basado en la fecha actual para asegurar un archivo por día que acumule los listados de procesos de ese día. La función GuardarProcesos obtiene los 10 procesos que más consumen CPU, formatea la información incluyendo la hora actual, y guarda el listado en el archivo correspondiente. Si el usuario logueado es "SOPORTE", también muestra el listado en pantalla. Finalmente, se programa una tarea para ejecutar esta función cada 60 minutos.



