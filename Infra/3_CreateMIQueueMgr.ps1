runas /user:MUSR_MQADMIN

$installed = ((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "IBM MQ").Length -gt 0

runas /user:MUSR_MQADMIN

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
    
    icacls S:\ /grant "mqm:(OI)(CI)F"

    crtmqm -ld S:\mqha\logs -md S:\mqha\qmgrs QMHA1

    if (!(Test-Path -Path 'S:\mqha\dspmqinf.txt' -PathType Leaf))
    {
        dspmqinf -o command QMHA1 > S:\mqha\dspmqinf.txt
    }

    #strmqm QMHA1
}






