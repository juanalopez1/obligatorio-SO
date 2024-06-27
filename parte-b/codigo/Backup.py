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
        powershell_path = "powershell.exe"
        result = subprocess.run([powershell_path, "-File", "backup.ps1"], check=True, capture_output=True, text=True)
        home_directory = os.path.expanduser(f'~{user}')
        backup_directory = os.path.join(home_directory, 'Respaldo')
        return os.path.exists(backup_directory)
    except subprocess.CalledProcessError as e:
        print(colors.RED + f"Error al ejecutar backup.ps1: {e}")
        return False


