function create_user{
    New-LocalUser -Name Contaduria
    Add-LocalGroupMember -Group Usuarios -Member Contaduria }


function create_asientos{
    Set-Location $HOME\Desktop

    if (-not (Test-Path "$HOME\Desktop\Asientos")) {
        New-Item -ItemType Directory -Path "$HOME\Desktop\Asientos"
    }

    New-Item -ItemType Directory -Path "$HOME\Desktop\Asientos\Diario"
    New-Item -ItemType Directory -Path "$HOME\Desktop\Asientos\Semanal"
    New-Item -ItemType Directory -Path "$HOME\Desktop\Asientos\Mensual" }

function do_bakcup{
    $rutaRespaldo = "C:\Respaldo"

    if (-not (Test-Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    Compress-Archive -Path "$HOME\Desktop\Asientos" -DestinationPath "$rutaRespaldo\$date.zip" }


function change_permissions{
    $nombreUsuario = "Contaduria"

    $rutaCarpetaUsuario = "$HOME" 

    $acl = Get-Acl $rutaCarpetaUsuario

    $permission = "$nombreUsuario", "Modify", "ContainerInherit,ObjectInherit", "None", "Deny"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
    $acl.SetAccessRule($accessRule)

    Set-Acl $rutaCarpetaUsuario $acl }

function block_access_to_dir{
    $nombreUsuario = "Contaduria"
    $carpetasRestringidas = @("C:\") 

    foreach ($carpeta in $carpetasRestringidas) {
        $aclRestringida = Get-Acl $carpeta
        $permissionRestringida = "$nombreUsuario", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRuleRestringida = New-Object System.Security.AccessControl.FileSystemAccessRule($permissionRestringida)
        $aclRestringida.SetAccessRule($accessRuleRestringida)
        Set-Acl $carpeta $aclRestringida
    }
}