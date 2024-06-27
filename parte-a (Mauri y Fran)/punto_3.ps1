function create_user{
    New-LocalUser -Name "Relaciones publicas"
    Add-LocalGroupMember -Group Usuarios -Member "Relaciones publicas" }



function create_comunicados{
    Set-Location $HOME\Desktop

    if (-not (Test-Path "$HOME\Desktop\Comunicados")) {
        New-Item -ItemType Directory -Path "$HOME\Desktop\Comunicados"
    }

    New-Item -ItemType Directory -Path "$HOME\Desktop\Comunicados\Semanal"
    New-Item -ItemType Directory -Path "$HOME\Desktop\Comunicados\Mensual" }

function do_bakcup{
    $rutaRespaldo = "C:\Respaldo"

    if (-not (Test-Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    Compress-Archive -Path "$HOME\Desktop\Comunicados" -DestinationPath "$rutaRespaldo\$date.zip" }

function change_permissions{
    $nombreUsuario = "Relaciones publicas"

    $rutaCarpetaUsuario = "$HOME" 

    $acl = Get-Acl $rutaCarpetaUsuario

    $permission = "$nombreUsuario", "Modify", "ContainerInherit,ObjectInherit", "None", "Deny"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
    $acl.SetAccessRule($accessRule)

    Set-Acl $rutaCarpetaUsuario $acl }

function block_access_to_dir{
    $nombreUsuario = "Relaciones publicas"
    $carpetasRestringidas = @("C:\") 

    foreach ($carpeta in $carpetasRestringidas) {
        $aclRestringida = Get-Acl $carpeta
        $permissionRestringida = "$nombreUsuario", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRuleRestringida = New-Object System.Security.AccessControl.FileSystemAccessRule($permissionRestringida)
        $aclRestringida.SetAccessRule($accessRuleRestringida)
        Set-Acl $carpeta $aclRestringida
    }
}