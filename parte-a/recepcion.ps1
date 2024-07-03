# Creación del usuario
New-LocalUser -Name Recepcion -NoPassword
Write-Output "Usuario 'Recepcion' creado exitosamente."

# Agregar el usuario al grupo
Add-LocalGroupMember -Group "Usuarios" -Member Recepcion
Write-Output "Usuario 'Recepcion' agregado al grupo Usuarios."

# Para que solo puedan acceder unicamente a sus carpetas

$userFolder = "C:\Users\Recepcion"

# Obtenemos la lista de todas las carpetas en C:\
$carpetas = Get-ChildItem -Path C:\ -Directory

foreach ($carpeta in $carpetas) {
    if ($carpeta.FullName -ne $userFolder) {
        # Creamos una regla de acceso denegado para cada carpeta excepto la del usuario
        $acl = Get-Acl -Path $carpeta.FullName
        $permission = "Recepcion", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
        $acl.AddAccessRule($accessRule)
        Set-Acl -Path $carpeta.FullName -AclObject $acl
    }
}

Write-Output "El usuario Recepcion no puede acceder a las carpetas en C:\"

