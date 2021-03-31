$rgName="mqTesting-rg"
$location="uksouth"
$deploymentName="mqTesting-deployment"

# Login
az login -s "5dd3998d-b447-44b5-884a-2da7751e365a"

# Create Resource Group
az group create -n $rgName  -l $location

# Get into right Dir
Set-Location .\Infra

# Validate ARM template
az deployment group validate -g $rgName `
    --template-file azuredeploy.json `
    --parameters azuredeploy.parameters.json

# Deploy ARM template
az deployment group create -n $deploymentName `
    -g $rgName `
    --template-file azuredeploy.json `
    --parameters azuredeploy.parameters.json

# Find VM list by location    
az vm list-sizes --location "westus"
az vm list-skus --location "westus"

# Get TimeZoneID
[System.TimeZoneInfo]::GetSystemTimeZones()|select -ExpandProperty Id