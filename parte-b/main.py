import optionA
import optionB
import optionC

validOptions = ["a", "b", "c", "A","B","C"]
print("Bienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
option= input("Opción: ")
while (option != "d" and option in validOptions):
    if (option == "a"):
        print(optionA.userList())
        print("\nBienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
    if(option == "b"):  
        optionB.getProcess()
        print("\nBienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
    if(option == "c"):
        optionC.doBackup()
        print("\nBienvenid@! Elija una opcipon para continuar \n a. Listar usuarios \n b. Consultar procesos \n c. Realizar respaldo \n d. Salida ")
        option= input("Opción: ")
if(option == "d"):
    exit
else:
    print("Opción inválida")
