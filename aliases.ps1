# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Directory Listing: Use `lsd.exe` if available
if (Get-Command lsd.exe -ErrorAction SilentlyContinue | Test-Path) {
    rm alias:ls -ErrorAction SilentlyContinue
    # Set `ls` to call `lsd.exe` and always use --color
    ${function:ls} = { lsd.exe --color always @args }
    # List all files in long format
    ${function:l} = { ls -lF @args }
    ${function:ll} = { ls -lF @args }
    # List all files in long format, including hidden files
    ${function:la} = { ls -laF @args }
    # List only directories
    ${function:lsd} = { ls -ladF @args }
}

Set-Alias grep Select-String
Set-Alias vi nvim

if (Get-Command git -ErrorAction SilentlyContinue) {
    ${function:gs} = { git status }
    ${function:ga} = { git add }
    ${function:gd} = { git diff }
    ${function:gf} = { git fetch }
    ${function:gco} = { git checkout }
}

# Clear the screen
Set-Alias c clear

# Reload the shell
${function:reload} = { . $PROFILE }
