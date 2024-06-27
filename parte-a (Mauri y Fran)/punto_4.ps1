New-LocalUser -Name Recepción
Add-LocalGroupMember -Group Usuarios -Member Recepción

$nombreUsuario = Recepción

# Ruta de la carpeta del usuario 
$rutaCarpetaUsuario = "$HOME" 

# Obtener el objeto de control de acceso (ACL) de la carpeta del usuario
$acl = Get-Acl $rutaCarpetaUsuario

# Denegar el permiso de instalación (ejemplo: modificar, eliminar, cambiar permisos)
$permission = "$nombreUsuario", "Modify", "ContainerInherit,ObjectInherit", "None", "Deny"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
$acl.SetAccessRule($accessRule)

# Aplicar los cambios de permisos a la carpeta del usuario
Set-Acl $rutaCarpetaUsuario $acl

# Restringir acceso a otras carpetas 
$carpetasRestringidas = @("C:\") 

foreach ($carpeta in $carpetasRestringidas) {
    $aclRestringida = Get-Acl $carpeta
    $permissionRestringida = "$nombreUsuario", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
    $accessRuleRestringida = New-Object System.Security.AccessControl.FileSystemAccessRule($permissionRestringida)
    $aclRestringida.SetAccessRule($accessRuleRestringida)
    Set-Acl $carpeta $aclRestringida
}

# Mensaje de confirmación
Write-Host "Los permisos para el usuario $nombreUsuario han sido configurados correctamente."