import psutil
from colors import colors

# Método encargado de la impresión e interacción con el usuario
def print_process():
    print(f"\nUsuario logueado: " + colors.GREEN + f"{psutil.Process().username().split('\\')[-1]}" + colors.ENDC + "\nSus procesos: ")
    get_process_list(psutil.Process().username())
    modification = input(colors.BLUE + "Desea hacer alguna modificación en alguno? S/N: " +colors.ENDC)
    modification = modification.lower()
    if modification == "s":
        option = input("1. Eliminar un proceso \n2. Pausar un proceso" + colors.YELLOW + "\nEscriba 'volver' si se arrepintió" +colors.ENDC + "\nOpción: ")
        if option == "1":
            id = input("Ingrese id del proceso que quiere eliminar: ")
            delete_proc(id)
            return
        elif option == "2":
            id = input("Ingrese id del proceso que quiere pausar: ")
            pause_proc(id)
            return
        elif option == "volver":
            return
        else:
            print(colors.RED + "Opción inválida")
    elif modification == "n":
        print("No se hicieron modificaciones.")
        return
    else:
        print(colors.RED + "Opción inválida")

# Responsable de obtener e imprimir la lista de los procesos de un usuario pasado por parametro
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
    print(colors.GREEN + "Total:", contador)
    return True

# Método llamado cuando el usuario desea eliminar un proceso con su id
def delete_proc(id):
    try:
        psutil.Process(int(id)).terminate()
        print(colors.GREEN + f"Proceso con PID {id} terminado.")
        return
    except psutil.NoSuchProcess:
        print(colors.RED + f"No existe el proceso con PID {id}.")
        return
    except psutil.AccessDenied:
        print(colors.YELLOW + f"Acceso denegado para terminar el proceso con PID {id}.")
        return
    
# Método llamado cuando el usuario desea pausar un proceso con su id
def pause_proc(id):
    try:
        psutil.Process(int(id)).suspend()
        print(colors.GREEN +f"Proceso con PID {id} pausado.")
        return
    except psutil.NoSuchProcess:
        print(colors.RED + f"No existe el proceso con PID {id}.")
        return
    except psutil.AccessDenied:
        print(colors.YELLOW + f"Acceso denegado para pausar el proceso con PID {id}.")
        exit