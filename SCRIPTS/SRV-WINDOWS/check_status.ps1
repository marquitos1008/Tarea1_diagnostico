write-host "=============================================="
write-host "     DIAGNOSTICO INICIAL DEL SISTEMA"
write-host "=============================================="
write-host ""

write-host "Nombre del equipo: "
write-host "----------------------------------"
write-host $env:COMPUTERNAME
write-host ""

write-host "Direcciones IP activas: "
write-host "----------------------------------"
$ip_lines = ipconfig | findstr "IPv4"
if ($ip_lines) {
    $counter = 1
    foreach ($line in $ip_lines) {
        $ip = ($line -split ":")[1].Trim()
        write-host "  IP$($counter): $ip"
        $counter++
    }
} else {
    write-host "  No se encontraron IPs"
}
write-host ""

write-host "Espacio en disco: "
write-host "--------------------------------"
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$freeGB = [math]::Round($disk.FreeSpace/1GB, 2)
$totalGB = [math]::Round($disk.Size/1GB, 2)
$percentGB = [math]::Round(($freeGB/$totalGB)*100, 2)
write-host "Disco C:: $freeGB GB libres de $totalGB GB ($percentGB%)"
write-host ""

write-host "=============================================="
write-host "        FIN DEL DIAGNOSTICO"
write-host "=============================================="
