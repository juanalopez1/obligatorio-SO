import subprocess
from User import User
from colors import colors

def get_user_list() -> list[User]:
    users = []
    command = 'Get-LocalUser | Select-Object -ExpandProperty Name'
    result = subprocess.run(["powershell.exe", command], capture_output=True, text=True)
    user_list = result.stdout.strip().split('\n')
    for username in user_list:
        new_user = User(username)
        users.append(new_user)
    return users

def set_local_groups(users: list[User]) -> list[User]: # crea los grupos dentro del programa y los usuarios
    groups = {}
    command = 'Get-LocalGroup | Select-Object -ExpandProperty Name'
    result = subprocess.run(["powershell.exe", command], capture_output=True, text=True)
    group_names = result.stdout.strip().split('\n')
    for name_group in group_names:
        command = f'Get-LocalGroupMember -Group {name_group} | Select-Object -ExpandProperty Name'
        result = subprocess.run(["powershell.exe", command], capture_output=True, text=True)
        result = result.stdout.strip().split("\n")
        if not result == ['']:
            result = [user.split('\\')[-1] for user in result]
            groups[name_group] = result
            for username in users:
                if username.name in groups[name_group]:
                    username.groups = username.groups.replace("-","") + name_group + ' '
    return users

def print_users():
    users = get_user_list()  
    users = set_local_groups(users) 
        
    for user in users:
        print(f"{colors.CYAN}╭────────────────────────────────────────────────────╮")
        print(f"│ {colors.ENDC}Nombre: {colors.MAGENTA}{user.name:<43}{colors.ENDC}{colors.CYAN}│")
        print(f"├────────────────────────────────────────────────────┤")
        print(f"│ {colors.ENDC}Grupos: {user.groups:<42} {colors.CYAN}│")
        print(f"│ {colors.ENDC}Último ingreso: {user.last_seen:<34} {colors.CYAN}│")
        print(f"│ {colors.ENDC}Respaldo: {user.backup:<40} {colors.CYAN}│")
        print(f"{colors.CYAN}╰────────────────────────────────────────────────────╯")

