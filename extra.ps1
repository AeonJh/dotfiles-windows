# Add any secrets and secret commands that you don't want tracked by the Git repository.

function Manage-Device {
    param (
        [string]$HardwareId,
        [string]$Action = "both",  # Default action is "both" (on and off)
        [string]${DeviceName},
        [string]$WSLDistro = "Ubuntu-20.04"  # Default distribution
    )

    switch ($Action) {
        "on" {
            # Attach the device
            usbipd attach --hardware-id $HardwareId --wsl $WSLDistro > $null 2>&1
            $result = ($LASTEXITCODE -ne 0) ? "Failure" : "Success"
            $color = ($result -eq "Failure") ? "Red" : "Green"
            Write-Host "Attach ${DeviceName}: [" -NoNewline
            Write-Host "$result" -ForegroundColor $color -NoNewline
            Write-Host "]"
        }
        "off" {
            # Detach the device
            usbipd detach --hardware-id $HardwareId > $null 2>&1
            $result = ($LASTEXITCODE -ne 0) ? "Failure" : "Success"
            $color = ($result -eq "Failure") ? "Red" : "Green"
            Write-Host "Detach ${DeviceName}: [" -NoNewline
            Write-Host "$result" -ForegroundColor $color -NoNewline
            Write-Host "]"
        }
        "both" {
            # Execute both "off" and "on"
            Manage-Device -HardwareId $HardwareId -Action "off" -DeviceName ${DeviceName} -WSLDistro $WSLDistro
            Manage-Device -HardwareId $HardwareId -Action "on" -DeviceName ${DeviceName} -WSLDistro $WSLDistro
        }
        default {
            Write-Host "Usage: <function-name> on | off | [default: both]" -ForegroundColor Yellow
        }
    }
}

function ble {
    param (
        [string]$Action = "both"  # Default action is "both"
    )
    Manage-Device -HardwareId "0489:e0cd" -Action $Action -DeviceName "MediaTek7961 Bluetooth"
}

function ch340 {
    param (
        [string]$Action = "both"  # Default action is "both"
    )
    Manage-Device -HardwareId "1a86:7523" -Action $Action -DeviceName "CH340"
}

function pl2303 {
    param (
        [string]$Action = "both"  # Default action is "both"
    )
    Manage-Device -HardwareId "067b:23a3" -Action $Action -DeviceName "PL2303"
}
