. .\funciones.ps1

param (
    [string]$username,
    [string]$dir_name
)

create_user Contaduria $username
create_dir Contaduria $username Asientos $dir_name
do_bakcup Contaduria $username Asientos $dir_name
change_permissions Contaduria $username 
block_access_to_dir Contaduria $username 
