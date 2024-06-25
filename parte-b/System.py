import subprocess
import win32net # type: ignore
import win32netcon # type: ignore
from User import User
from Group import Group


def set_local_groups() -> list[User]: # crea los grupos dentro del programa y los usuarios
    users = []
    powershell_path = "powershell.exe"
    command = 'Get-LocalGroup | Select-Object -ExpandProperty Name'
    result = subprocess.run([powershell_path, command], capture_output=True, text=True)
    group_names = result.stdout.strip().split('\n')
    for name_group in group_names:
        new_group = Group(name_group)
        command = f'Get-LocalGroupMember -Group {name_group} | Select-Object -ExpandProperty Name'
        result = subprocess.run([powershell_path, command], capture_output=True, text=True)
        usernames = result.stdout.split('\n')
        for username in usernames:
            if username != '':
                username = username.strip().split('\\')
                username = username[-1]
                new_user = User(username,name_group, '')
                new_group.users.append(new_user)
                users.append(new_user)
    return users

def print_users():
    users = set_local_groups()
    for user in users:
        print(f"Nombre: {user.name} | Grupos: {user.groups} | Ultimo ingreso: {user.last_seen} | Respaldo: {user.backup}")
