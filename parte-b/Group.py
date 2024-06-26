import os
import subprocess
import psutil
import ctypes
from ctypes.wintypes import DWORD, LPWSTR, BOOL

class Group:
    def __init__(self, name):
        self.name = name
        self.users = []

    
