# loader.ps1

$modules = @("components", "functions", "aliases", "exports", "extra")
$basePath = Split-Path -Parent $PROFILE

foreach ($module in $modules) {
    $file = "$module.ps1"
    $fullPath = Join-Path $basePath $file
    if (Test-Path $fullPath) {
        try {
            . $fullPath
            Write-Host "✅ Loaded $file" -ForegroundColor Green
        } catch {
            Write-Warning "⚠️ Failed to load $file`nReason: $($_.Exception.Message)"
        }
    }
}
