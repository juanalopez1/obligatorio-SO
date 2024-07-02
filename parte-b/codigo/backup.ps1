function do_backup {
    param (
        [string]$username
    )

    $rutaRespaldo = "C:\Respaldo"
    $date = Get-Date -Format "ddMMMyyyy"
    $date = $date.ToUpper()

    # Define el nombre del archivo zip de respaldo
    $zipFileName = "$rutaRespaldo\$date-$username.zip"

    # Comprueba si el directorio de respaldo existe, si no, créalo
    if (-Not (Test-Path -Path $rutaRespaldo)) {
        New-Item -ItemType Directory -Path $rutaRespaldo
    }

    # Comprime el directorio de escritorio del usuario y lo guarda en la ruta de respaldo
    Compress-Archive -Path "C:\Users\$username\Desktop" -DestinationPath $zipFileName

    # Salida para confirmar la operación
    Write-Output "Backup completed: $zipFileName"
}