# Script para control de procesos

# Crear la carpeta PROCESOS si no existe
$carpetaProcesos = "C:\PROCESOS"
if (-not (Test-Path -Path $carpetaProcesos)) {
    New-Item -ItemType Directory -Path $carpetaProcesos
}

# Nombre del archivo basado en la fecha actual
$nombreArchivo = "Procesos_" + (Get-Date -Format "yyyyMMdd") + ".txt"
$rutaArchivo = Join-Path -Path $carpetaProcesos -ChildPath $nombreArchivo

# Función para obtener y guardar los procesos
function GuardarProcesos {
    # Obtener los 10 procesos que más consuman CPU
    $procesos = Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
    $contenido = "Hora: " + (Get-Date -Format "HH:mm:ss") + "`n" + ($procesos | Format-Table -AutoSize | Out-String)

    # Guardar en el archivo
    Add-Content -Path $rutaArchivo -Value $contenido

    # Mostrar en pantalla si el usuario es SOPORTE
    if ([System.Security.Principal.WindowsIdentity]::GetCurrent().Name -eq "DOMINIO\SOPORTE") {
        Write-Output $contenido
    }
}

# Programar la tarea para ejecutarse cada 60 minutos
$trigger = New-JobTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 60) -RepetitionDuration ([TimeSpan]::MaxValue)
Register-ScheduledJob -Name "ControlProcesos" -ScriptBlock ${function:GuardarProcesos} -Trigger $trigger