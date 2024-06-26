import psutil

def get_process():
    print(f"Usuario logueado: {psutil.Process().username().split('\\')[-1]} \nSus procesos: ")
    get_process_list(psutil.Process().username())
    modification = input("Desea hacer alguna modificación en alguno? S/N: ")
    if modification == "s" or modification == "S":
        option = input("a. Eliminar un proceso \nb. Pausar un proceso \nEscriba 'volver' si se arrepintió \nOpción: ")
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
        elif option == "volver":
            return
        else:
            print("Opción inválida")
    elif modification == "n" or modification == "N":
        print("No se hicieron modificaciones.")
        return
    else:
        print("Opción inválida")


def get_process_list(user: str) -> bool:
    contador = 0
    for process in psutil.process_iter(['pid', 'name', 'username','status']):
        process_info = process.info
        name = str(process_info['username'])
        name.split('\\')
        if (user == name):
            pid = process_info['pid']
            name = process_info['name']
            cpu_percent = process.cpu_percent()
            status = process_info['status']
            contador += 1
            print(f"Nombre: {name} | Identificador: {pid} | Porcentaje CPU: {cpu_percent}% | Estado: {status}")
    print("Total:", contador)
    return True
