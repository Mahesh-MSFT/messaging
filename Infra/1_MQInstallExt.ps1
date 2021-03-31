# Create Install Media Folder
New-Item -Path "C:\" -Name "MQInstallMedia" -ItemType "directory" -Force

# MQ Installation Path as Of Mar-21
$source = 'https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev921_windows.zip'

# Destination to save the file
$destination = 'C:\MQInstallMedia\mqadv_dev921_windows.zip'

# Set TLS
[Net.ServicePointManager]::SecurityProtocol = "Tls, Tls11, Tls12, Ssl3"

#Download the file
Invoke-WebRequest -Uri $source -OutFile $destination