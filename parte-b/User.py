import os
import psutil
import ctypes
from ctypes.wintypes import DWORD, LPWSTR, BOOL


class User:
    def __init__(self, name, groups, last_seen):
        self.name = name
        self.groups = groups
        self.last_seen = last_seen
        self.backup = self.does_it_have_backup()
        #self.sid = self.get_user_sid()
        #self.processes = self.get_processes()

    def does_it_have_backup(self) -> str:
        home_directory = os.path.expanduser(f'~{self.name}')
        backup_directory = os.path.join(home_directory, 'respaldo')
        response = os.path.exists(backup_directory)
        if (response):
            return "Sí"
        return "No tiene respaldo"
    
    
    """def get_user_sid(self):
        sid = ctypes.create_unicode_buffer(256)
        sid_size = DWORD(256)
        domain_name = ctypes.create_unicode_buffer(256)
        domain_size = DWORD(256)
        sid_name_use = DWORD(0)
        
        if not advapi32.LookupAccountNameW(None, username, sid, ctypes.byref(sid_size), domain_name, ctypes.byref(domain_size), ctypes.byref(sid_name_use)):
            raise ctypes.WinError(ctypes.get_last_error())
        
        sid_string = ctypes.create_unicode_buffer(256)
        if not advapi32.ConvertSidToStringSidW(sid, ctypes.byref(sid_string)):
            raise ctypes.WinError(ctypes.get_last_error())
        
        return sid_string.value"""

    """def get_processes(self):
        user_processes = []
        for process in psutil.process_iter(attrs=['pid', 'name', 'username']):
            try:
                pid = process.info['pid']
                name = process.info['name']
                cpu_percent = process.cpu_percent()
                status = process.status()
                user_processes.append(process)
                print(f"Nombre: {name} | Identificador: {pid} | Porcentaje CPU: {cpu_percent}% | Estado: {status}")
                return user_processes
            except psutil.NoSuchProcess:
                continue
        return user_processes"""
    
    def print_processes(self):
        for process in psutil.process_iter(attrs=['pid', 'name', 'username']):
            pid = process.info['pid']
            name = process.info['name']
            cpu_percent = process.cpu_percent()
            status = process.status()
            print(f"Nombre: {name} | Identificador: {pid} | Porcentaje CPU: {cpu_percent}% | Estado: {status}")
            
    def get_group(self) -> str:
        ...

    """def get_sid(self):
        LPTSTR = LPWSTR
        PSID = ctypes.c_void_p
        DWORD_PTR = ctypes.POINTER(DWORD)
        sid = ctypes.create_string_buffer(28)
        sid_size = DWORD(28)
        domain_name = ctypes.create_unicode_buffer(256)
        domain_size = DWORD(256)
        sid_name_use = DWORD(0)
        
        if not advapi32.LookupAccountNameW(None, self.name, sid, ctypes.byref(sid_size), domain_name, ctypes.byref(domain_size), ctypes.byref(sid_name_use)):
            raise ctypes.WinError(ctypes.get_last_error())
        
        return sid.raw"""
    
