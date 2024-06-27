import datetime
import threading
import User
import Proccess
import Backup
import System
from colors import colors

valid_options = ["a", "b", "c", "A","B","C"]
print(colors.MAGENTA + "Bienvenido! Elije una opción para continuar \n" + colors.ENDC + " a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
option= input("Opción: ")
while (option != "d" and option in valid_options):
    option =option.lower()
    if (option == "a"):
        print(colors.GREEN + "Cargando usuarios..." + colors.ENDC)
        System.print_users()
        print(colors.MAGENTA + "\nBienvenido! Elije una opción para continuar \n" + colors.ENDC + " a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
    if(option == "b"):  
        Proccess.get_process()
        print(colors.MAGENTA + "\nBienvenido! Elije una opción para continuar \n" + colors.ENDC + " a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
    if(option == "c"):
        Backup.print_users_backup()
        print(colors.MAGENTA + "\nBienvenido! Elije una opción para continuar \n" + colors.ENDC + " a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
if(option == "d"):
    print(colors.BG_MAGENTA + "Ejecución terminada." + colors.ENDC)
    exit
else:
    print("Opción inválida")

    