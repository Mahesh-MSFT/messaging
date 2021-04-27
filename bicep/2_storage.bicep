resource dataDisk 'Microsoft.Compute/disks@2020-12-01' = {
  name: 'mqSharedDisk'
  location: resourceGroup().location
  sku:{
    name: 'Premium_LRS'
  }
  properties:{
    creationData:{
      createOption:'Empty'
    }
    diskSizeGB: 256
    maxShares: 2
  }
}

output dataDiskOp_Id string = dataDisk.id
