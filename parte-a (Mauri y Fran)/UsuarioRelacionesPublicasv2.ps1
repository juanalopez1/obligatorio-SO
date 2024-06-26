# Ruta del Escritorio del usuario actual
$comunicadosPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), "Comunicados")

# Estas seran las carpetas que crearemos dentro de la carpeta 'Comunicados'
$subfolders = @("Semanal", "Mensual")

# Verificar y crear la carpeta "Comunicados" en el Escritorio si no existe
if (-not (Test-Path -Path $comunicadosPath)) {
    New-Item -Path $comunicadosPath -ItemType Directory
    Write-Output "Se creo la carpeta 'Comunicados' en el escritorio."
}

# Verificar y crear las subcarpetas dentro de "Comunicados" si no existen
foreach ($folder in $subfolders) {
    $folderPath = [System.IO.Path]::Combine($comunicadosPath, $folder)
    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory
        Write-Output "Carpeta '$folder' creada en 'Comunicados'."
    }
}

# Ruta de la carpeta "Respaldo" en la raíz del disco principal, por ahora sera dentro de la carpeta C:\
$backupRootPath = "C:\Respaldo"

# Fecha actual en formato para nombre de carpeta (ddMMMyyyy)
$dateString = Get-Date -Format "ddMMMyyyy"
$backupPath = [System.IO.Path]::Combine($backupRootPath, $dateString)

# Crear la carpeta "Respaldo" en la raíz del disco principal si no existe
if (-not (Test-Path -Path $backupRootPath)) {
    New-Item -Path $backupRootPath -ItemType Directory
    Write-Output "Carpeta 'Respaldo' creada en la raíz del disco principal."
}

# Crear la carpeta de respaldo con la fecha actual
if (-not (Test-Path -Path $backupPath)) {
    New-Item -Path $backupPath -ItemType Directory
    Write-Output "Carpeta de respaldo creada con la fecha actual en 'Respaldo'."
}

# Realizar el respaldo de la carpeta "Comunicados"
Copy-Item -Path $comunicadosPath -Destination $backupPath -Recurse
Write-Output "Respaldo de la carpeta 'Comunicados' completado."


# Fin del script
Write-Output "Terminado"