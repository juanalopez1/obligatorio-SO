function create_user{
    New-LocalUser -Name Recepción
    Add-LocalGroupMember -Group Usuarios -Member Recepción }

function change_permissions{
    $nombreUsuario = Recepción

    $rutaCarpetaUsuario = "$HOME" 

    $acl = Get-Acl $rutaCarpetaUsuario

    $permission = "$nombreUsuario", "Modify", "ContainerInherit,ObjectInherit", "None", "Deny"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($permission)
    $acl.SetAccessRule($accessRule)

    Set-Acl $rutaCarpetaUsuario $acl }

function block_access_to_dir{
    $nombreUsuario = Recepción
    $carpetasRestringidas = @("C:\") 

    foreach ($carpeta in $carpetasRestringidas) {
        $aclRestringida = Get-Acl $carpeta
        $permissionRestringida = "$nombreUsuario", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Deny"
        $accessRuleRestringida = New-Object System.Security.AccessControl.FileSystemAccessRule($permissionRestringida)
        $aclRestringida.SetAccessRule($accessRuleRestringida)
        Set-Acl $carpeta $aclRestringida
    }
}