# Crear usuario y agregarlo a un grupo local
New-LocalUser -Name "Relaciones Publicas"
Add-LocalGroupMember -Group Usuarios -Member "Relaciones Publicas"

# Cambiar la ubicación actual al escritorio del usuario
Set-Location $HOME\Desktop

if (!(Test-Path "$HOME\Desktop\Comunicados")) {
    New-Item -ItemType Directory -Path "$HOME\Desktop\Comunicados"
}

New-Item -ItemType Directory -Path "$HOME\Desktop\Comunicados\Semanal"
New-Item -ItemType Directory -Path "$HOME\Desktop\Comunicados\Mensual"

# Definir la ruta de respaldo en el disco principal
$rutaRespaldo = "C:\Respaldo"

# Verificar si existe la carpeta de respaldo y crearla si no existe
if (!(Test-Path $rutaRespaldo)) {
    New-Item -ItemType Directory -Path $rutaRespaldo
}

# Obtener la fecha actual en el formato especificado
$date = Get-Date -Format "ddMMMyyyy"
$date = $date.ToUpper()

# Comprimir la carpeta "Asientos" y guardarla en la carpeta de respaldo con la fecha como nombre
Compress-Archive -Path "$HOME\Desktop\Comunicados" -DestinationPath "$rutaRespaldo\$date.zip"

# Definir el nombre del usuario al que se aplicarán los cambios
$nombreUsuario = "Relaciones Publicas"

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