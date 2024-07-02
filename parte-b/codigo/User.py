import os
import subprocess
import wmi


class User:
    def __init__(self, name: str):
        self.name = name
        self.groups = '-'
        self.last_seen = self.format_datetime(self.get_last_login())
        self.backup = self.does_it_have_backup()

    def does_it_have_backup(self) -> str:
        backup_root_directory = os.path.join('C:\\', 'Respaldo')
        if os.path.exists(backup_root_directory):
            for directory_name in os.listdir(backup_root_directory):
                full_directory_path = os.path.join(backup_root_directory, directory_name)
                if os.path.isdir(full_directory_path) and self.name in directory_name:
                    return "Sí"
        return "No tiene"
    
    def get_last_login(self) -> str:
        try:
            c = wmi.WMI()
            for session in c.Win32_LogonSession():
                for logon in session.references("Win32_LoggedOnUser"):
                    if logon.Antecedent.Name == self.name:
                        return session.StartTime
            return "-"
        except:
            return "-"
        
    
    def format_datetime(self, start_time: str) -> str:
        if start_time != "-":
            start_time = start_time.split('.')[0]
            
            year = start_time[0:4]
            month = start_time[4:6]
            day = start_time[6:8]
            hour = start_time[8:10]
            minute = start_time[10:12]
            second = start_time[12:14]

            months = {
                "01": "Jan", "02": "Feb", "03": "Mar", "04": "Apr",
                "05": "May", "06": "Jun", "07": "Jul", "08": "Aug",
                "09": "Sep", "10": "Oct", "11": "Nov", "12": "Dec"
            }

            month_name = months[month]
            return f"{day}-{month_name}-{year} {hour}:{minute}:{second}"
        return start_time




