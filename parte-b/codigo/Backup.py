import os
import subprocess
import System
from colors import colors

def print_users_backup():
    print(colors.GREEN + "Usuarios sin respaldo: " + colors.ENDC)
    users = System.get_user_list()
    for user in users:
        if user.backup == "No tiene":
            print(user.name)
    elegido = input("\nIngrese usuario al que desea hacerle respaldo: " + colors.YELLOW + "\nEscriba 'volver' si se arrepintió " + colors.ENDC + "\n - ")
    elegido = elegido.lower()
    if elegido != "volver":
        if do_backup(elegido):
            home_directory = os.path.expanduser(f'~{elegido}')
            print(colors.GREEN + f"Respaldo hecho con éxito. Puede verlo en {home_directory}")
            return
        else:
            print(colors.RED + "No se pudo realizar el respaldo")
            return
    else:
        return

    
def do_backup(user) -> bool:
    try:
        result = subprocess.run(
            ["powershell.exe", "-File", "backup.ps1", "-username", user],
            check=True,
            capture_output=True,
            text=True
        )
        backup_directory = os.path.join('C:\\', 'Respaldo')
        
        # Verifica si existe el directorio de respaldo
        if os.path.exists(backup_directory):
            # Busca en los nombres de los directorios dentro de C:\Respaldo
            for directory_name in os.listdir(backup_directory):
                full_directory_path = os.path.join(backup_directory, directory_name)
                if os.path.isdir(full_directory_path) and user in directory_name:
                    return True
        return False
    except subprocess.CalledProcessError as e:
        return False


