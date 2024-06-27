function create_user {
    param (
        [string]$username
    )
    New-LocalUser -Name $username
    Add-LocalGroupMember -Group Usuarios -Member $username 
}


function create_dir {
    param (
        [string]$dir_name,
        [string]$username
    )
    
    Set-Location C:\Users\$username\Desktop

    if (-not (Test-Path "C:\Users\$username\Desktop\$dir_name")) {
        New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name"
    }

    if ($dir_name -eq "Asientos") {
        New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name\Diario"
    }
    New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name\Semanal"
    New-Item -ItemType Directory -Path "C:\Users\$username\Desktop\$dir_name\Mensual" 
}

function do_bakcup {
    param (
        [string]$dir_name,
        [string]$username
    )
    $rutaRespaldo = "C:\Respaldo"

    if (-not (Test-Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    Compress-Archive -Path "C:\Users\$username\Desktop\$dir_name" -DestinationPath "$rutaRespaldo\$date.zip" 
}


function change_permissions {
    param (
        [string]$username
    )

    $rutaCarpetaUsuario = "C:\Users\$username" 

    $acl = Get-Acl $rutaCarpetaUsuario

    $permission = $username, "Modify", "ContainerInherit,ObjectInherit", "None", "Deny"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
    $acl.SetAccessRule($accessRule)

    Set-Acl $rutaCarpetaUsuario $acl 
}

function block_access_to_dir {
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