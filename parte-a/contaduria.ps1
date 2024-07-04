# Creación del usuario
New-LocalUser -Name Contaduria -NoPassword
Write-Output "Usuario 'Contaduria' creado exitosamente."

# Agregar el usuario al grupo
Add-LocalGroupMember -Group "Usuarios" -Member Contaduria
Write-Output "Usuario 'Contaduria' agregado al grupo Usuarios."

# Creación directorio Asientos y sus respectivos subdirectorios
$desktopPath = "C:\Users\Contaduria\Desktop"
if (-not (Test-Path $desktopPath)) {
    Write-Output "La carpeta Desktop de Contaduria no existe o no se puede acceder."
    return
}

# Crear la carpeta principal
$dirPath = Join-Path -Path $desktopPath -ChildPath Asientos
if (-not (Test-Path $dirPath)) {
    New-Item -ItemType Directory -Path $dirPath
}

# Crear subdirectorios específicos
$subDirs = @("Diario","Semanal", "Mensual")
foreach ($subDir in $subDirs) {
    $subDirPath = Join-Path -Path $dirPath -ChildPath $subDir
    if (-not (Test-Path $subDirPath)) {
        New-Item -ItemType Directory -Path $subDirPath
    }
}
Write-Output "El directorio Asientos se ha creado con éxito en el escritorio de Contaduria"

# Respaldo de las carpetas
$rutaRespaldo = "C:\Respaldo"

if (-not (Test-Path $rutaRespaldo)) {
    New-Item -ItemType Directory -Path $rutaRespaldo
}

$rutaRespaldoUser = "C:\Respaldo\Contaduria"

if (-not (Test-Path $rutaRespaldoUser)) {
    New-Item -ItemType Directory -Name Contaduria -Path $rutaRespaldoUser
}

$date = Get-Date -Format "ddMMMyyyy"
$date = $date.ToUpper()

Compress-Archive -Path "C:\Users\Contaduria\Desktop\Asientos" -DestinationPath "$rutaRespaldo\$date-Contaduria.zip" 
Write-Output "El respaldo se ha creado con éxito. Puede verlo en $rutaRespaldoUser"


# Para que solo puedan acceder unicamente a sus carpetas

$userFolder = "C:\Users\Contaduria"

# Obtenemos la lista de todas las carpetas en C:\
$carpetas = Get-ChildItem -Path C:\ -Directory

foreach ($carpeta in $carpetas) {
    if ($carpeta.FullName -ne $userFolder) {
        # Creamos una regla de acceso denegado para cada carpeta excepto la del usuario
        $acl = Get-Acl -Path $carpeta.FullName
        $permission = "Contaduria", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
        $acl.AddAccessRule($accessRule)
        Set-Acl -Path $carpeta.FullName -AclObject $acl
    }
}

Write-Output "El usuario Contaduria no puede acceder a las carpetas en C:\"

