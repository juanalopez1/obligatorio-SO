Import-Module .\funciones.ps1

create_user -username Contaduria 
create_dir -username Contaduria -dir_name Asientos 
do_bakcup -username Contaduria -dir_name Asientos 
set_user_folder_permissions -username Contaduria 
block_access_to_users -username Contaduria 
