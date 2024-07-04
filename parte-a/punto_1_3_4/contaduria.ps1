.\parte-a\punto_1_3_4\funciones.ps1

create_user -username "Contaduria" 
block_access_to_user -username "Contaduria" 

# DESPÚES DE INICIAR SESIÓN EJECUTAR ESTOS
create_dir -username "Contaduria" -dir_name "Asientos" 
do_backup -username "Contaduria" -dir_name "Asientos" 