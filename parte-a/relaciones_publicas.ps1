. .\funciones.ps1

param (
    [string]$username,
    [string]$dir_name
)

create_user "Relaciones publicas" $username
create_dir "Relaciones publicas" $username Comunicados $dir_name
do_bakcup "Relaciones publicas" $username Comunicados $dir_name
change_permissions "Relaciones publicas" $username 
block_access_to_dir "Relaciones publicas" $username 
