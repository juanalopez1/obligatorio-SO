import datetime
import User
import Proccess
import Backup
import System

validOptions = ["a", "b", "c", "A","B","C"]
print("Bienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
option= input("Opción: ")
while (option != "d" and option in validOptions):
    option =option.lower()
    if (option == "a"):
        System.print_users()
        print("\nBienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
    if(option == "b"):  
        Proccess.get_process()
        print("\nBienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
    if(option == "c"):
        Backup.print_users_backup()
        print("\nBienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
if(option == "d"):
    print("Ejecución terminada.")
    exit
else:
    print("Opción inválida")