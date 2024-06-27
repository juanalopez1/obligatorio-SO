# Carga el script que contiene las funciones
. .\funciones.ps1

# Define los parámetros
param (
    [string]$username,
    [string]$dir_name
)

create_user Contaduria $username
create_user "Relaciones publicas" $username
create_user Recepcion $username

create_dir Contaduria $username Asientos $dir_name
create_dir "Relaciones publicas" $username Comunicados $dir_name

do_bakcup Contaduria $username Asientos $dir_name
do_bakcup "Relaciones publicas" $username Comunicados $dir_name

change_permissions Contaduria $username 
change_permissions "Relaciones publicas" $username 
change_permissions Recepcion $username 

block_access_to_dir Contaduria $username 
block_access_to_dir "Relaciones publicas" $username 
block_access_to_dir Recepcion $username 