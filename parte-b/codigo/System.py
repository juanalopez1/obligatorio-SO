import subprocess
from User import User

def get_user_list() -> list[User]:
        users = []
        powershell_path = "powershell.exe"
        command = 'Get-LocalUser | Select-Object -ExpandProperty Name'
        result = subprocess.run([powershell_path, command], capture_output=True, text=True)
        user_list = result.stdout.strip().split('\n')
        for username in user_list:
            new_user = User(username)
            users.append(new_user)
        return users

def set_local_groups(users: list[User]) -> list[User]: # crea los grupos dentro del programa y los usuarios
    groups = {}
    powershell_path = "powershell.exe"
    command = 'Get-LocalGroup | Select-Object -ExpandProperty Name'
    result = subprocess.run([powershell_path, command], capture_output=True, text=True)
    group_names = result.stdout.strip().split('\n')
    for name_group in group_names:
        command = f'Get-LocalGroupMember -Group {name_group} | Select-Object -ExpandProperty Name'
        result = subprocess.run([powershell_path, command], capture_output=True, text=True)
        result = result.stdout.strip().split("\n")
        if not result == ['']:
            result = [user.split('\\')[-1] for user in result]
            groups[name_group] = result
            for username in users:
                if username.name in groups[name_group]:
                    username.groups += name_group + ' '
    return users


def print_users():
    users = get_user_list()
    users = set_local_groups(users)
    for user in users:
        if user.groups == '':
            print(f"Nombre: {user.name} | Grupos: no pertenece a ningún grupo | Ultimo ingreso: {user.last_seen} | Respaldo: {user.backup}")
        else:
            print(f"Nombre: {user.name} | Grupos: {user.groups} | Ultimo ingreso: {user.last_seen} | Respaldo: {user.backup}")
        

