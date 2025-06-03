function h2d {
    param([Parameter(Mandatory)][string]$Hex)
    [Convert]::ToInt32($Hex, 16)
}

function d2h {
    param([Parameter(Mandatory)][int]$Dec)
    "{0:X}" -f $Dec
}

function jhc {
    param([string]$Json)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Json)
    ($bytes | ForEach-Object { "{0:X2}" -f $_ }) -join ' '
}
