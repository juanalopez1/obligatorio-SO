# Creación de los usuarios
function create_user {
    param (
        [string]$username
    )
    
    if (-not (Get-LocalUser -Name $userName -ErrorAction SilentlyContinue)) {
        # Se crea el usuario sin contraseña
        New-LocalUser -Name $username -NoPassword -Description "Usuario $username" -PasswordNeverExpires:$true -AccountNeverExpires:$true | Out-Null
        Write-Output "Usuario '$username' creado exitosamente."
    }
    else {
        Write-Output "El usuario '$username' ya existe. No se creara"
    }

    # Agregar el usuario al grupo
    Add-LocalGroupMember -Group "Usuarios" -Member $username | Out-Null
    Write-Output "Usuario '$username' agregado al grupo Usuarios."
}

# Creación de sus carpetas
function create_dir {
    param (
        [string]$username,    
        [string]$dir_name
    )
    
    if (-not (Test-Path "C:\Users\$username\Desktop\$dir_name")) {
        New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name"
    }

    if ($dir_name -eq "Asientos") {
        New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name\Diario"
    }
    New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name\Semanal"
    New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name\Mensual" 
}

# Respaldo de las carpetas
function do_bakcup {
    param (
        [string]$username,
        [string]$dir_name
    )
    $rutaRespaldo = "C:\Respaldo"

    if (-not (Test-Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    Compress-Archive -Path "C:\Users\$username\Desktop\$dir_name" -DestinationPath "$rutaRespaldo\$date.zip" 
}

# Para que solo puedan modificar sus carpetas
function set_user_folder_permissions {
    param (
        [string]$username
    )

    $rutaCarpetaUsuario = "C:\Users\$username" 

    $acl = Get-Acl $rutaCarpetaUsuario

    # Permisos para permitir la modificación
    $permission = $username, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
    $acl.SetAccessRule($accessRule)

    Set-Acl $rutaCarpetaUsuario $acl 
}

# Para que solo puedan acceder unicamente a sus carpetas
function block_access_to_users {
    param (
        [string]$username
    )
    $nombreUsuario = $username
    $carpetasRestringidas = @("C:\") 

    foreach ($carpeta in $carpetasRestringidas) {
        $aclRestringida = Get-Acl $carpeta
        $permissionRestringida = "$nombreUsuario", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRuleRestringida = New-Object System.Security.AccessControl.FileSystemAccessRule($permissionRestringida)
        $aclRestringida.SetAccessRule($accessRuleRestringida)
        Set-Acl $carpeta $aclRestringida
    }
}
