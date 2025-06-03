Set-PSReadLineKeyHandler -Key Alt+h -Function BackwardChar
Set-PSReadLineKeyHandler -Key Alt+j -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Alt+k -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Alt+l -Function ForwardChar

$env:EDITOR = "nvim"
