<#
.SYNOPSIS
    JohaSecurity TOL - Herramienta de Reconocimiento y Escaneo de Red Local.
    Descubre dispositivos activos en la subred y analiza sus puertos abiertos.
#>

# Forzar codificación UTF8 para evitar caracteres extraños en la consola
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Clear-Host
Write-Host "🛡️ [JohaSecurity TOL] Iniciando Escáner de Red y Puertos..." -ForegroundColor Cyan
Write-Host "==========================================================================" -ForegroundColor Cyan

# 1. Obtener la IP local automáticamente
$IPInfo = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "169.254.*" -and $_.IPAddress -notlike "127.*" -and $_.InterfaceAlias -notlike "*Loopback*" } | Select-Object -First 1
if (-not $IPInfo) {
    Write-Host "❌ No se detectó una conexión de red IPv4 activa." -ForegroundColor Red
    Exit
}

$Subred = ($IPInfo.IPAddress -split "\.")[0..2] -join "."
Write-Host "[+] Tu IP Local: $($IPInfo.IPAddress)" -ForegroundColor Gray
Write-Host "[+] Escaneando el segmento de red: $Subred.1 al $Subred.254" -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------"

$PuertosAAnalizar = @(22, 80, 443, 445, 3389)

# 2. Bucle de escaneo universal
foreach ($i in 1..254) {
    $IPObjetivo = "$Subred.$i"
    
    # Usamos la clase Ping de .NET (Compatible con cualquier versión de Windows y ultra veloz)
    $Ping = New-Object System.Net.NetworkInformation.Ping
    try {
        $Reply = $Ping.Send($IPObjetivo, 60) # 60 milisegundos de tiempo de espera máximo
        $EstaActivo = ($Reply.Status -eq "Success")
    } catch {
        $EstaActivo = $false
    }
    
    if ($EstaActivo) {
        Write-Host "`n🌐 Dispositivo Activo Encontrado: $IPObjetivo" -ForegroundColor Green
        
        # 3. Escanear los puertos usando sockets directos de red
        foreach ($Puerto in $PuertosAAnalizar) {
            $TcpClient = New-Object System.Net.Sockets.TcpClient
            $Connect = $TcpClient.BeginConnect($IPObjetivo, $Puerto, $null, $null)
            $Wait = $Connect.AsyncWaitHandle.WaitOne(50, $false)

            if ($TcpClient.Connected) {
                $Servicio = switch($Puerto) {
                    22   { "SSH (Acceso Remoto Seguro)" }
                    80   { "HTTP (Servidor Web)" }
                    443  { "HTTPS (Servidor Web Seguro)" }
                    445  { "SMB (Compartición de Archivos)" }
                    3389 { "RDP (Escritorio Remoto Windows)" }
                    Default { "Desconocido" }
                }
                Write-Host "   [+] Puerto Abierto: $Puerto -> $Servicio" -ForegroundColor Yellow
                $TcpClient.Close()
            } else {
                $TcpClient.Close()
            }
        }
    }
}

Write-Host "`n==========================================================================" -ForegroundColor Cyan
Write-Host "🛡️ Escaneo de red finalizado con éxito por JohaSecurity TOL." -ForegroundColor Cyan
