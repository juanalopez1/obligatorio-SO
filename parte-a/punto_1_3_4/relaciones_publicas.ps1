.\parte-a\punto_1_3_4\funciones.ps1

create_user -username "Relaciones públicas" 
block_access_to_user -username "Relaciones públicas"

# DESPÚES DE INICIAR SESIÓN EJECUTAR ESTOS
create_dir -username "Relaciones públicas" -dir_name "Comunicados" 
do_backup -username "Relaciones públicas" -dir_name "Comunicados" 