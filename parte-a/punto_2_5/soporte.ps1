function create_admin {
    param(
        [string] $username
    )
    New-LocalUser -Name $username
    Add-LocalGroupMember -Group Administradores -Member $username
}

create_admin -username "Soporte"
