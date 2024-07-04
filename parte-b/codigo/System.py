import subprocess
from User import User
from colors import colors
import wmi

# Obtiene la lista de los usuarios del sistema y crea las instancias de los mismos, guardandolas en una lista para mas adelante acceder a ellos
def get_user_list()-> list[User]:
    c = wmi.WMI()
    users = []
    for user in c.Win32_UserAccount():
        new_user = User(user.name)
        users.append(new_user)
    return users

# Recibe las instancias de los usuarios y retorna la misma lista pero modifica el atributo "groups", asignandole a cada usuario sus 
# grupos determinados. Esto lo puede hacer ya que tambien es el responsable de obtener los grupos (y sus respectivos miembros) del sistema
def set_groups(users: list[User]) -> list[User]:
    c = wmi.WMI()
    groups = c.Win32_Group()
    for group in groups:
        members = group.associators(wmi_result_class="Win32_UserAccount")
        for member in members:
            for user in users:
                if user.name == member.Name:
                    user.groups = user.groups.replace("-","") + group.Name + ' '

    return users

# Imprime los usuarios y sus respectivos atributos
def print_users():
    users = set_groups(get_user_list()) 
        
    for user in users:
        print(f"{colors.CYAN}╭────────────────────────────────────────────────────╮")
        print(f"│ {colors.ENDC}Nombre: {colors.MAGENTA}{user.name:<43}{colors.ENDC}{colors.CYAN}│")
        print(f"├────────────────────────────────────────────────────┤")
        print(f"│ {colors.ENDC}Grupos: {user.groups:<42} {colors.CYAN}│")
        print(f"│ {colors.ENDC}Último ingreso: {user.last_seen:<34} {colors.CYAN}│")
        print(f"│ {colors.ENDC}Respaldo: {user.backup:<40} {colors.CYAN}│")
        print(f"{colors.CYAN}╰────────────────────────────────────────────────────╯")

