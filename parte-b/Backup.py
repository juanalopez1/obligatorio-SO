import os
import subprocess
import System
def print_users_backup():
    print("Usuarios sin respaldo: ")
    users = System.set_local_groups( )
    for user in users:
        if user.backup == "No tiene respaldo":
            print(user.name)
    elegido = input("Ingrese usuario al que desea hacerle respaldo: ")
    if do_backup(elegido):
        print("Respaldo hecho con éxito. Puede verlo en {}")
        return
    else:
        print("No se pudo realizar el respaldo")
        return

def do_backup(user,bat) -> bool:
   resultado = subprocess.run([ruta_bat], check=True, shell=True, text=True, capture_output=True)
   return os.path.exists(backup_directory)


def ejecutar_bat(ruta_bat):
    # Ejecutar el archivo .bat
    resultado = subprocess.run([ruta_bat], check=True, shell=True, text=True, capture_output=True)
    # Imprimir la salida del archivo .bat
    print("Salida del archivo .bat:")


