# Install Media Folder Exists
$installFolder = 'C:\Windows\MQInstallMedia'
# MQ Installation Path as Of Mar-21
$installSource = 'https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev921_windows.zip'
# MQ Extract FOlder
$mqExtractFolder = 'C:\MQInstallMedia\mqadv_dev921_windows'
# MQ Installable MSI Path
$mqMSIFile = "C:\MQInstallMedia\mqadv_dev921_windows\MQServer\MSI\IBM MQ.msi"
# MQ Install Log File Path
$mqInstallLogFilePath = 'C:\MQInstallMedia\mqadv_dev921_windows\Install.Log'

 # Set TLS
 [Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"

if (!(Test-Path -Path $InstallFolder))
{
    # Create Install Media Folder
    New-Item -Path "C:\" -Name "MQInstallMedia" -ItemType "directory" -Force
}

# Destination to save the file
$destinationFilePath = 'C:\MQInstallMedia\mqadv_dev921_windows.zip'

if (!(Test-Path -Path $destinationFilePath -PathType Leaf))
{
   
    #Download the file
    $response = Invoke-WebRequest -Uri $installSource -OutFile $destinationFilePath

    # If download is successful
    if ($response.StatusCode -eq 200)
    {
        Expand-Archive -LiteralPath $destinationFilePath $mqExtractFolder -Force
    }
}
else {
    # Check if Zip File in not extracted
    if (!(Test-Path -Path $mqExtractFolder))
    {
        # Extract
        Expand-Archive -LiteralPath $destinationFilePath -DestinationPath $mqExtractFolder -Force
    }

    # Run MSI
    if ((Test-Path -Path $mqMSIFile -PathType Leaf))
    {
        $MSIArguments = @(
            "/i"
            ('"{0}"' -f  $mqMSIFile)
            "/L*v"
            $mqInstallLogFilePath
            "TRANSFORMS=1033.mst AGREETOLICENSE=yes ADDLOCAL=Server"
        )

        # Run MSI
        Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow 

        # Check Error Level
        Write-Output %ERRORLEVEL%
    }
}
