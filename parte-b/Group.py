import os
import subprocess
import psutil
import ctypes
from ctypes.wintypes import DWORD, LPWSTR, BOOL

class Group:
    def __init__(self, name):
        self.name = name
        self.users = []

    
    
    powershell_path = "powershell.exe"

    # Comando de PowerShell que deseas ejecutar
    command = "Get-local"

    # Ejecuta el comando de PowerShell desde Python
    result = subprocess.run([powershell_path, command], capture_output=True, text=True)

    # Imprime la salida del comando
    print(result.stdout)
    
