import subprocess
from User import User
from colors import colors
import wmi

def get_user_list()-> list[User]:
    c = wmi.WMI()
    users = []
    for user in c.Win32_UserAccount():
        new_user = User(user.name)
        users.append(new_user)
    return users

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

def print_users():
    users = get_user_list()  
    users = set_groups(users) 
        
    for user in users:
        print(f"{colors.CYAN}╭────────────────────────────────────────────────────╮")
        print(f"│ {colors.ENDC}Nombre: {colors.MAGENTA}{user.name:<43}{colors.ENDC}{colors.CYAN}│")
        print(f"├────────────────────────────────────────────────────┤")
        print(f"│ {colors.ENDC}Grupos: {user.groups:<42} {colors.CYAN}│")
        print(f"│ {colors.ENDC}Último ingreso: {user.last_seen:<34} {colors.CYAN}│")
        print(f"│ {colors.ENDC}Respaldo: {user.backup:<40} {colors.CYAN}│")
        print(f"{colors.CYAN}╰────────────────────────────────────────────────────╯")

