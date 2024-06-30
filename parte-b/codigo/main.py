import threading

import psutil
import User
import Proccess
import Backup
import System
from colors import colors

def menu():
    menu = (
    f"{colors.BOLD}{colors.WHITE}\n"
    f"╭─────────────────────────────────╮\n"
    f"│          {colors.CYAN}Bienvenido! {colors.WHITE}           │\n"
    f"│ Elije una opción para continuar │\n"
    f"├─────────────────────────────────┤\n"
    f"│ {colors.MAGENTA}1. Listar usuarios            {colors.WHITE}  │\n"
    f"│ {colors.MAGENTA}2. Consultar procesos         {colors.WHITE}  │\n"
    f"│ {colors.MAGENTA}3. Realizar respaldo          {colors.WHITE}  │\n"
    f"│ {colors.MAGENTA}4. Salir                      {colors.WHITE}  │\n"
    f"╰─────────────────────────────────╯\n"
    f"{colors.ENDC}" )

    print(menu)

    option = input("Opción elegida: ")
    menu_options(int(option) if option.isdigit() else 0)

def menu_options(chosen_option: int):
    while chosen_option not in [1, 2, 3, 4]:
        print(colors.RED + "ERROR: la opción elegida no puede ser admitida" + colors.ENDC)
        new_chosen_option = input("Opción elegida: ")
        chosen_option = int(new_chosen_option) if new_chosen_option.isdigit() else 0

    if chosen_option == 1:
        print(colors.GREEN + "Cargando usuarios..." + colors.ENDC)
        System.print_users()
        menu()

    elif chosen_option == 2:
        Proccess.get_process()
        menu()

    elif chosen_option == 3:
        Backup.print_users_backup()
        menu()

    elif chosen_option == 4:
        print(colors.BOLD + colors.CYAN + "Gracias por usar nuestro programa. ¡Hasta pronto!" + colors.ENDC)
        exit
    
menu()