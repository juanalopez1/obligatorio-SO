import os
import subprocess
import System

def print_users_backup():
    print("\nUsuarios sin respaldo: ")
    users = System.get_user_list()
    for user in users:
        if user.backup == "No tiene":
            print(user.name)
    elegido = input("\nIngrese usuario al que desea hacerle respaldo: \nEscriba 'volver' si se arrepintió \n - ")
    elegido = elegido.lower()
    if elegido != "volver":
        if do_backup(elegido):
            home_directory = os.path.expanduser(f'~{elegido}')
            print(f"Respaldo hecho con éxito. Puede verlo en {home_directory}")
            return
        else:
            print("No se pudo realizar el respaldo")
            return
    else:
        return

    
def do_backup(user) -> bool:
    try:
        powershell_path = "powershell.exe"
        result = subprocess.run([powershell_path, "-File", "respaldo.ps1"], check=True, capture_output=True, text=True)
        home_directory = os.path.expanduser(f'~{user}')
        backup_directory = os.path.join(home_directory, 'Respaldo')
        return os.path.exists(backup_directory)
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar respaldo.ps1: {e}")
        print(f"Salida estándar: {e.stdout}")
        print(f"Error estándar: {e.stderr}")
        return False


