# Creación de los usuarios
function create_user {
    param ($username)
    
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
    param ($username, $dir_name)
    
    $desktopPath = "C:\Users\$username\Escritorio"

    # Verificar si la carpeta Desktop del usuario existe
    if (-not (Test-Path $desktopPath)) {
        Write-Output "La carpeta Escritorio de $username no existe o no se puede acceder."
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
function do_bakcup {
    param ($username, $dir_name)
    $rutaRespaldo = "C:\Respaldo"

    if (-not (Test-Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    Compress-Archive -Path "C:\Users\$username\Escritorio\$dir_name" -DestinationPath "$rutaRespaldo\$date.zip" 
    Write-Output "El respaldo se ha creado con éxito. Puede verlo en $rutaRespaldo"
}

# Para que solo puedan modificar sus carpetas
function set_user_folder_permissions {
    param ($username)

    $rutaCarpetaUsuario = "C:\Users\$username" 

    $acl = Get-Acl $rutaCarpetaUsuario

    # Permisos para permitir la modificación
    $permission = $username, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
    $acl.SetAccessRule($accessRule)

    Set-Acl $rutaCarpetaUsuario $acl 
    Write-Output "Se concedieron permisos de modificacion a $rutaCarpetaUsuario exitosamente"
}

# Para que solo puedan acceder unicamente a sus carpetas
function block_access_to_users {
    param ($username)

    # Ruta de la carpeta del usuario específico
    $userFolder = "C:\Users\$username"

    # Obtenemos la lista de todas las carpetas en C:\
    $carpetas = Get-ChildItem -Path C:\ -Directory

    foreach ($carpeta in $carpetas) {
        if ($carpeta.FullName -ne $userFolder) {
            # Creamos una regla de acceso denegado para cada carpeta excepto la del usuario
            $acl = Get-Acl -Path $carpeta.FullName
            $permission = "$username", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
            $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
            $acl.AddAccessRule($accessRule)
            Set-Acl -Path $carpeta.FullName -AclObject $acl
        }
    }

    Write-Output "El usuario $username no puede acceder a las carpetas en C:\ excepto $userFolder"
}
