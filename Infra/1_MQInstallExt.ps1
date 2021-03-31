# Create Install Media Folder
New-Item -Path "c:\" -Name "MQInstallMedia" -ItemType "directory" -Force

# MQ Installation Path as Of Mar-21
$source = 'https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev921_windows.zip'

# Destination to save the file
$destination = 'c:\MQInstallMedia\mqadv_dev921_windows.zip'

#Download the file
Invoke-WebRequest -Uri $source -OutFile $destination