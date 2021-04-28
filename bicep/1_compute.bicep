param vmSize string
param dataDiskId string
param nicId string

resource firstVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
location: resourceGroup().location
name: 'mqQueueMgr-VM'
properties: {
  hardwareProfile: {
    vmSize: vmSize
  }
  osProfile: {
    computerName: 'mqQueueMgr-VM'
    adminUsername: 'mqQueueMgr-VM-UID'
    adminPassword: 'P@ssw0rd1234'
  }
  storageProfile:{
    imageReference:{
      publisher: 'MicrosoftWindowsServer'
      offer: 'WindowsServer'
      sku: '2012-R2-Datacenter'
      version: 'latest'
    }
    osDisk:{
        name: 'mqQueueMgr-VMOSDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
    }
    dataDisks:[
      {
        lun: 0
        createOption: 'Attach'
        managedDisk: {
            id: dataDiskId
        }
      }
    ]
  }
  networkProfile:{
    networkInterfaces:[
        {
          id: nicId
        }
      ]
    }
  }
}  

resource firstVmExtension 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: 'mqQueueMgr-VM/MQReadinessExtension'
  location: resourceGroup().location
  dependsOn: [
    firstVM
  ]
  properties:{
      publisher: 'Microsoft.Compute'
      type: 'CustomScriptExtension'
      typeHandlerVersion: '1.10'
      autoUpgradeMinorVersion: true
      settings: {
        fileUris: [
          'https://raw.githubusercontent.com/Mahesh-MSFT/messaging/main/Infra/MainScript.ps1'
          'https://raw.githubusercontent.com/Mahesh-MSFT/messaging/main/Infra/1_MQInstallExt.ps1'
          'https://raw.githubusercontent.com/Mahesh-MSFT/messaging/main/Infra/2_PrepareDisks.ps1'
          'https://raw.githubusercontent.com/Mahesh-MSFT/messaging/main/Infra/3_CreateMIQueueMgr.ps1'
        ]
      }
      protectedSettings:{
        commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted  -File MainScript.ps1'
      }
    }
  }
  
output firstVmNameOp object = firstVM
