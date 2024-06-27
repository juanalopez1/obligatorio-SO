Set-Location $HOME
New-Item -ItemType Directory -Force -Path "$HOME\Comunicados\Semanal"
New-Item -ItemType Directory -Force -Path "$HOME\Comunicados\Mensual"
New-Item -ItemType Directory -Force -Path "$HOME\Respaldo"
$rutaRespaldo = "$HOME\Respaldo"
$date = Get-Date -Format "ddMMMyyyy"
$date = $date.toUpper()
Compress-Archive -Path "$HOME\Comunicados" -DestinationPath "$rutaRespaldo\$date.zip"