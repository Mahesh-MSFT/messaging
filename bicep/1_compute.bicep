param vmSize string

module storageMod '2_storage.bicep' = {
  name: 'storageMod'
}

module networkMod '3_networking.bicep'= {
  name: 'networkMod'
}

resource firstVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
location: resourceGroup().location
name: 'firstVM'
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
            id: storageMod.outputs.dataDiskOp_Id
        }
      }
    ]
  }
  networkProfile:{
    networkInterfaces:[
      {
        id: networkMod.outputs.nicOp_Id
      }
    ]
  }
}

}

output firstVmNameOp object = firstVM
