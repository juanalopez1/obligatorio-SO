Import-Module.\funciones.ps1

param (
    [string]$username,
    [string]$dir_name
)

create_user -username Recepcion
set_user_folder_permissions -username Recepcion
block_access_to_users -username Recepcion 
