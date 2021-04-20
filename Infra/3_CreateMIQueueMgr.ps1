$installed = ((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "IBM MQ").Length -gt 0

If(-Not $installed) {
	Write-Host "MQ  is Not installed.";
} else {
	Write-Host "MQ is installed."

    Set-Location S:\

    if (!(Test-Path -Path 'S:\mqha'))
    {
        mkdir mqha
    }
    
    Set-Location mqha
    
    if (!(Test-Path -Path 'S:\mqha\logs'))
    {
        mkdir logs
    }
    
    if (!(Test-Path -Path 'S:\mqha\qmgrs'))
    {
        mkdir qmgrs
    }
    
    crtmqm -ld S:\mqha\logs -md S:\mqha\qmgrs QMHA1
    
    strmqm QMHA1
}






