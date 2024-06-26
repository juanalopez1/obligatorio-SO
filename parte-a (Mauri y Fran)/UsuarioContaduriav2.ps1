# Ruta del Escritorio del usuario actual
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), "Asientos")

# Subcarpetas a crear dentro de "Asientos"
$subfolders = @("Diario", "Semanal", "Mensual")

# Verificar y crear la carpeta "Asientos" en el Escritorio si no existe
if (-not (Test-Path -Path $desktopPath)) {
    New-Item -Path $desktopPath -ItemType Directory
    Write-Output "Se creo la carpeta 'Asientos' en el escritorio."
}

# Verificar y crear las subcarpetas dentro de "Asientos" si no existen
foreach ($folder in $subfolders) {
    $folderPath = [System.IO.Path]::Combine($desktopPath, $folder)
    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory
        Write-Output "Carpeta '$folder' creada en 'Asientos'."
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

# Realizar el respaldo de la carpeta "Asientos"
Copy-Item -Path $desktopPath -Destination $backupPath -Recurse
Write-Output "Respaldo de la carpeta 'Asientos' completado."



# Fin del script
Write-Output "Terminado"
 