import subprocess
import win32net # type: ignore
import win32netcon # type: ignore
from User import User
from Group import Group

def get_user_list() -> list[User]:
    users = []
    powershell_path = "powershell.exe"
    command = 'Get-LocalUser | Select-Object -ExpandProperty Name'
    result = subprocess.run([powershell_path, command], capture_output=True, text=True)
    user_list = result.stdout.strip().split('\n')
    for username in user_list:
        username = str(username)
        new_user = User(username,"")
        users.append(new_user)
    return users

def set_local_groups(myUsers: list[User]): # crea los grupos dentro del programa y los usuarios
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
            for username in myUsers:
                if username.name in groups[name_group]:
                    username.groups.append(name_group)

def get_user_login_events(users: list[User]):
    id = 4624
    for user in users:
        # Corrección aquí: Concatena la cadena con el nombre del usuario
        command = f"Get-WinEvent -FilterHashtable @{{'Id'={id},'Data':{'UserName':'{user.name}'}}} | Select-Object -ExpandProperty TimeCreated"
        result = subprocess.run(['powershell', '-Command', command], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        if result.stderr:
            print(f"Error ejecutando el comando: {result.stderr}")
            continue  # Continúa con el siguiente usuario si hay un error
        
        user.last_seen = result.stdout


def print_users():
    users = get_user_list()
    set_local_groups(users)
    get_user_login_events(users)
    for user in users:
        #print(f"Nombre: {user.name} | Grupos: {user.groups} | Respaldo: {user.backup}")
        print(f"Nombre: {user.name} | Grupos: {user.groups} | Ultimo ingreso: {user.last_seen} | Respaldo: {user.backup}")

