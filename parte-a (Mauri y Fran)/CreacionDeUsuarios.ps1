# Usaremos un unico grupo de usuarios, que sera "Users"
$commonGroup = "Users"  # Puedes cambiarlo a otro grupo si es necesario

# Se crean los usuarios(en este caso sin contraseña) y seran agregados a un unico grupo(se puede cambiar)
foreach ($userName in ("Contaduria", "Soporte", "RelacionesPublicas", "Recepcion")) {
    # Vemos si el usuario ya existe
    if (-not (Get-LocalUser -Name $userName -ErrorAction SilentlyContinue)) {
        # Se crea el usuario sin contraseña
        New-LocalUser -Name $userName -NoPassword -Description "Usuario $userName" -PasswordNeverExpires:$true -AccountNeverExpires:$true | Out-Null
        Write-Output "Usuario '$userName' creado exitosamente."
    } else {
        Write-Output "El usuario '$userName' ya existe. No se creara"
    }

    # Agregar el usuario al grupo
    Add-LocalGroupMember -Group $commonGroup -Member $userName | Out-Null
    Write-Output "Usuario '$userName' agregado al grupo '$commonGroup'."
}

# Fin
Write-Output "Creación de usuarios completada."
