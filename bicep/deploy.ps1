$rgName="mqTesting2-rg"
$location="uksouth"

az group create -n $rgName  -l $location

cd .\bicep
az deployment group create -f ./main.bicep -g $rgName

az monitor activity-log list --correlation-id c1730b50-98db-4877-8b93-29064b306bc0