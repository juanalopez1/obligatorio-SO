# Creación de los usuarios
function create_user {
    param ([string]$username)
    
    if (-not (Get-LocalUser -Name $userName -ErrorAction SilentlyContinue)) {
        # Se crea el usuario sin contraseña
        New-LocalUser -Name $username -NoPassword
        Write-Output "Usuario '$username' creado exitosamente."
    }
    else {
        Write-Output "El usuario '$username' ya existe. No se creara"
    }

    # Agregar el usuario al grupo
    Add-LocalGroupMember -Group "Usuarios" -Member $username
    Write-Output "Usuario '$username' agregado al grupo Usuarios."
}

# Creación de carpetas
function create_dir {
    param ([string]$username, [string]$dir_name)
    
    $desktopPath = "C:\Users\$username\Desktop"

    # Verificar si la carpeta Desktop del usuario existe
    if (-not (Test-Path $desktopPath)) {
        Write-Output "La carpeta Desktop de $username no existe o no se puede acceder."
        return
    }

    # Crear la carpeta principal
    $dirPath = Join-Path -Path $desktopPath -ChildPath $dir_name
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

    # Crear directorio adicional "Diario" si $dir_name es "Asientos"
    if ($dir_name -eq "Asientos") {
        $diarioPath = Join-Path -Path $dirPath -ChildPath "Diario"
        if (-not (Test-Path $diarioPath)) {
            New-Item -ItemType Directory -Path $diarioPath
        }
    }

    Write-Output "El directorio $dir_name se ha creado con éxito en el escritorio de $username"
}

# Respaldo de las carpetas
function do_backup {
    param ([string]$username, [string]$dir_name)
    $rutaRespaldo = "C:\Respaldo\$username"

    if (-not (Test-Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    Compress-Archive -Path "C:\Users\$username\Desktop\$dir_name" -DestinationPath "$rutaRespaldo\$date.zip" 
    Write-Output "El respaldo se ha creado con éxito. Puede verlo en $rutaRespaldo"
}

# Para que no puedan acceder a las carpetas de los demas usuarios
function block_access_to_user {
    param ([string]$username)
    $usersFolder = "C:\Users"
    # Ruta de la carpeta del usuario específico
    $itsFolder = "$usersFolder\$username"
    # Obtener todas las carpetas dentro de C:\Users
    $folders = Get-ChildItem -Path $usersFolder -Directory
    foreach ($folder in $folders) {
        # Verificar que la carpeta no sea la del usuario específico
        if ($folder.FullName -ne $itsFolder) {
            $acl = Get-Acl -Path $folder.FullName
            $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($username, "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny")
            $acl.AddAccessRule($accessRule)
            Set-Acl -Path $folder.FullName -AclObject $acl
        }
    }

    Write-Output "El usuario $username no puede acceder a las carpetas en $usersFolder excepto $itsFolder"
}



create_user -username "Contaduria" 
create_dir -username "Contaduria" -dir_name "Asientos" 
do_backup -username "Contaduria" -dir_name "Asientos" 
block_access_to_user -username "Contaduria" 

create_user -username "Relaciones públicas" 
create_dir -username "Relaciones públicas" -dir_name "Comunicados" 
do_backup -username "Relaciones públicas" -dir_name "Comunicados" 
block_access_to_user -username "Relaciones públicas"

create_user -username "Recepcion" 
block_access_to_user -username "Recepcion" 


