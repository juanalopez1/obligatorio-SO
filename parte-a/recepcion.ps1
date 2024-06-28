. .\funciones.ps1

param (
    [string]$username,
    [string]$dir_name
)

create_user Recepcion $username
change_permissions Recepcion $username 
block_access_to_dir Recepcion $username 
