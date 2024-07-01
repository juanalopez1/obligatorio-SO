. parte-a\funciones.ps1

create_user "Relaciones publicas" 
create_dir "Relaciones publicas" "Comunicados" 
do_bakcup "Relaciones publicas" "Comunicados" 
set_user_folder_permissions "Relaciones publicas" 
block_access_to_users "Relaciones publicas" 