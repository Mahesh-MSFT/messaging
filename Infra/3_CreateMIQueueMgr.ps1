$installed = ((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "IBM MQ").Length -gt 0

If(-Not $installed) {
	Write-Host "MQ  is Not installed.";
} else {
	Write-Host "MQ is installed."

    Set-Location S:\

    mkdir mqha
    
    Set-Location mqha
    
    mkdir logs
    
    mkdir qmgrs
    
    crtmqm -ld S:\mqha\logs -md S:\mqha\mqha\qmgrs QMHA1
    
    strmqm QMHA1
}






