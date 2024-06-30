Import-Module.\funciones.ps1

create_user -username "Relaciones publicas" 
create_dir -username "Relaciones publicas" -dir_name Comunicados 
do_bakcup -username "Relaciones publicas" -dir_name Comunicados 
set_user_folder_permissions -username "Relaciones publicas" 
block_access_to_users -username "Relaciones publicas" 
