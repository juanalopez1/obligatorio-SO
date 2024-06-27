import os
import subprocess
import wmi


class User:
    def __init__(self, name: str):
        self.name = name
        self.groups = ''
        self.last_seen = self.format_datetime(self.get_last_login())
        self.backup = self.does_it_have_backup()

    def does_it_have_backup(self) -> str:
        home_directory = os.path.expanduser(f'~{self.name}')
        backup_directory = os.path.join(home_directory, 'Respaldo')
        response = os.path.exists(backup_directory)
        if (response):
            return "Sí"
        return "No tiene"
    
    """def last_access(self) -> str:
        command = 'Get-EventLog -LogName Security | Where-Object { $_.EventID -eq 4624 } | Select-Object -First 1 -ExpandProperty TimeGenerated'
        full_command = f'powershell -Command "{command}" -Verb RunAs'
        result = subprocess.run(full_command, shell=True)
        if result.stdout != '':
            return result.stdout
        else:
            return 'No se puede acceder al ultimo ingreso'"""
        
    

    def get_last_login(self) -> str:
        try:
            c = wmi.WMI()
            for session in c.Win32_LogonSession():
                for logon in session.references("Win32_LoggedOnUser"):
                    if logon.Antecedent.Name == self.name:
                        return session.StartTime
            return "No se encontró el usuario o no tiene sesiones activas."
        except Exception as e:
            return "No se encontró el usuario o no tiene sesiones activas."
    
    def format_datetime(self, start_time: str) -> str:
        if start_time != "No se encontró el usuario o no tiene sesiones activas.":
            # Elimina la fracción de segundo si está presente
            start_time = start_time.split('.')[0]
            
            # Extrae las partes de la fecha y hora
            year = start_time[0:4]
            month = start_time[4:6]
            day = start_time[6:8]
            hour = start_time[8:10]
            minute = start_time[10:12]
            second = start_time[12:14]

            # Diccionario para convertir de número de mes a nombre de mes
            months = {
                "01": "Jan", "02": "Feb", "03": "Mar", "04": "Apr",
                "05": "May", "06": "Jun", "07": "Jul", "08": "Aug",
                "09": "Sep", "10": "Oct", "11": "Nov", "12": "Dec"
            }

            month_name = months[month]
            return f"{day}-{month_name}-{year} {hour}:{minute}:{second}"
        return start_time




