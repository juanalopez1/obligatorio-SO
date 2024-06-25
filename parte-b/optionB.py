import psutil
import optionA

def getProcess():
    user= input("De que usuario desea gestionar los procesos?: ")
    if(getProcessList(user)):
        modification = input("Desea hacer alguna modificación en alguno? S/N: ")
        if modification == "s" or modification == "S":
            option = input("a. Eliminar un proceso \nb. Pausar un proceso \nOpción: ")
            if option == "a":
                id = input("Ingrese id del proceso que quiere eliminar: ")
                try:
                    psutil.Process(int(id)).terminate()
                    print(f"Proceso con PID {id} terminado.")
                    return
                except psutil.NoSuchProcess:
                    print(f"No existe el proceso con PID {id}.")
                    return
                except psutil.AccessDenied:
                    print(f"Acceso denegado para terminar el proceso con PID {id}.")
                    return
            elif option == "b":
                id = input("Ingrese id del proceso que quiere pausar: ")
                try:
                    psutil.Process(int(id)).suspend()
                    print(f"Proceso con PID {id} pausado.")
                    return
                except psutil.NoSuchProcess:
                    print(f"No existe el proceso con PID {id}.")
                    return
                except psutil.AccessDenied:
                    print(f"Acceso denegado para pausar el proceso con PID {id}.")
                    exit
            else:
                print("Opción inválida")
        elif modification == "n" or modification == "N":
            print("No se hicieron modificaciones.")
            return
        else:
            print("Opción inválida")
    else:
        return


def getProcessList(user: str) -> bool:
    contador = 0
    if user in optionA.userList():
        for process in psutil.process_iter(['pid', 'name', 'username']):
            namename = str(process.info['username'])
            if namename.__contains__(user):
                pid = process.info['pid']
                name = process.info['name']
                cpu_percent = process.cpu_percent()
                status = process.status()
                contador +=1
                print(f"Nombre: {name} | Identificador: {pid} | Porcentaje CPU: {cpu_percent}% | Estado: {status}")
        print(contador)
        return True
    else:
        print("\nNombre de usuario inválido")
        return False    