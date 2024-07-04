import os
import shutil
import subprocess
import System
from colors import colors

# Imprime los usuarios sin respaldo y hace las preguntas al usuario
def print_users_backup():
    print(colors.GREEN + "Usuarios sin respaldo: " + colors.ENDC)
    users = System.get_user_list()
    for user in users:
        if user.backup == "No tiene":
            print(user.name)
    elegido = input("\nIngrese usuario al que desea hacerle respaldo: " + colors.YELLOW + "\nEscriba 'volver' si se arrepintió " + colors.ENDC + "\n - ")
    elegido = elegido.lower()
    elegido = elegido.capitalize()
    if elegido != "volver":
        dire = str(input("Ingrese nombre del directorio de 'Desktop' a respaldar: "))
        if do_backup(elegido, dire):
            print(colors.GREEN + f"Respaldo del directorio {dire} hecho con éxito. Puede verlo en C:\Respaldo\{elegido}")
            return
        else:
            print(colors.RED + "No se pudo realizar el respaldo")
            return
    else:
        return

# Hace el respaldo de la carpeta pasada por parametro del usuario pasado por parametro
def do_backup(user:str, folder_name:str) -> bool:
    try:
        folder_name = folder_name.capitalize()
        desktop_dir = os.path.join(os.path.expanduser(f"~{user}"), "Desktop", folder_name) # ruta de la carpeta a respaldar
        if not os.path.exists(desktop_dir):
            folder_name = str(input("La carpeta que ingresó no existe. Ingrese una carpeta válida: "))
            folder_name = folder_name.capitalize()
            desktop_dir = os.path.join(os.path.expanduser(f"~{user}"), "Desktop", folder_name) # ruta de la carpeta a respaldar
        
        backup_root = os.path.join("C:\\Respaldo", user) # ruta de la carpeta del usuario dentro de respaldo
        
        # si respaldo no existe, se crea
        if not os.path.exists(backup_root):
            os.makedirs(backup_root)
        
        resultado = subprocess.run(["powershell.exe", "-File", "parte-b\\codigo\\date.ps1"], capture_output=True, text=True)
        get_date = resultado.stdout.strip()

        if resultado.returncode != 0:
            print("Error al obtener la fecha del script de PowerShell")
            return False
        
        backup_file = os.path.join(backup_root, f"{get_date}.zip")
        shutil.make_archive(base_name=backup_file.replace('.zip', ''), format='zip', root_dir=desktop_dir)

        return True
    except Exception as e:
        return False




