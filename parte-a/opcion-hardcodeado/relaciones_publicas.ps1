# Creación del usuario
New-LocalUser -Name "Relaciones publicas" -NoPassword
Write-Output "Usuario 'Relaciones publicas' creado exitosamente."

# Agregar el usuario al grupo
Add-LocalGroupMember -Group "Usuarios" -Member "Relaciones publicas"
Write-Output "Usuario 'Relaciones publicas' agregado al grupo Usuarios."

# Creación directorio Comunicados y sus respectivos subdirectorios
$desktopPath = "C:\Users\Relaciones publicas\Desktop"
if (-not (Test-Path $desktopPath)) {
    Write-Output "La carpeta Desktop de Relaciones publicas no existe o no se puede acceder."
    return
}

# Crear la carpeta principal
$dirPath = Join-Path -Path $desktopPath -ChildPath Comunicados
if (-not (Test-Path $dirPath)) {
    New-Item -ItemType Directory -Path $dirPath
}

# Crear subdirectorios específicos
$subDirs = @("Semanal", "Mensual")
foreach ($subDir in $subDirs) {
    $subDirPath = Join-Path -Path $dirPath -ChildPath $subDir
    if (-not (Test-Path $subDirPath)) {
        New-Item -ItemType Directory -Path $subDirPath
    }
}
Write-Output "El directorio Comunicados se ha creado con éxito en el escritorio de Relaciones publicas"

# Respaldo de las carpetas
$rutaRespaldo = "C:\Respaldo"

if (-not (Test-Path $rutaRespaldo)) {
    New-Item -ItemType Directory -Path $rutaRespaldo
}

$rutaRespaldoUser = "C:\Respaldo\Relaciones publicas"

if (-not (Test-Path $rutaRespaldoUser)) {
    New-Item -ItemType Directory -Path $rutaRespaldoUser
}

$date = Get-Date -Format "ddMMMyyyy"
$date = $date.ToUpper()

Compress-Archive -Path "C:\Users\Relaciones publicas\Desktop\Comunicados" -DestinationPath "$rutaRespaldoUser\$date.zip" 
Write-Output "El respaldo se ha creado con éxito. Puede verlo en $rutaRespaldoUser"


# Para que solo puedan acceder unicamente a sus carpetas

$userFolder = "C:\Users\Relaciones publicas"

# Obtenemos la lista de todas las carpetas en C:\
$carpetas = Get-ChildItem -Path C:\ -Directory

foreach ($carpeta in $carpetas) {
    if ($carpeta.FullName -ne $userFolder) {
        # Creamos una regla de acceso denegado para cada carpeta excepto la del usuario
        $acl = Get-Acl -Path $carpeta.FullName
        $permission = "Relaciones publicas", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
        $acl.AddAccessRule($accessRule)
        Set-Acl -Path $carpeta.FullName -AclObject $acl
    }
}

Write-Output "El usuario Relaciones publicas no puede acceder a las carpetas en C:\"

