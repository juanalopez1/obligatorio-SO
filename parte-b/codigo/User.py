import datetime
import os
import re
import subprocess
import psutil
import ctypes
from ctypes.wintypes import DWORD, LPWSTR, BOOL



class User:
    def __init__(self, name: str):
        self.name = name
        self.groups = ''
        self.last_seen = ''
        self.backup = self.does_it_have_backup()
        #self.sid = self.get_user_sid()
        #self.processes = self.get_processes()

    def does_it_have_backup(self) -> str:
        home_directory = os.path.expanduser(f'~{self.name}')
        backup_directory = os.path.join(home_directory, 'Respaldo')
        response = os.path.exists(backup_directory)
        if (response):
            return "Sí"
        return "No tiene"
    
    """def last_seen(self) -> str:
        command = 'Get-EventLog -LogName Security | Where-Object { $_.EventID -eq 4624 } | Select-Object -First 1 -ExpandProperty TimeGenerated'
        full_command = f'powershell -Command "{command}" -Verb RunAs'
        result = subprocess.run(full_command, shell=True)
        result.stdout"""
    
    def last_access(self) -> str:
        powershell_path = "powershell.exe"
        result = subprocess.run([powershell_path, "-File", "comando.ps1"], check=True, capture_output=True, text=True)
        if result.stdout != '':
            return result.stdout
        else:
            return 'No se puede acceder al ultimo ingreso'



