. .\funciones.ps1

param (
    [string]$username,
    [string]$dir_name
)

create_user Recepcion $username
set_user_folder_permissions Recepcion $username 
block_access_to_users Recepcion $username 
