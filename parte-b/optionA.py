import subprocess

def userList():
    result = subprocess.run(['net', 'user'], capture_output=True, text=True)
    output = result.stdout
    users = []
    for line in output.split('\n'):
        if line.strip() and not line.startswith('--------------------------------') and not line.startswith('The command completed'):
            users.extend(line.split())
    return users

def groupList():
    ...

def lastSeen():
    ...

def printer():
    users = userList()
    for user in users:
        print(f"Nombre de usuario: {user}  | Grupo: {...} | Fecha de ultimo acceso: {...} | Respaldo: ")