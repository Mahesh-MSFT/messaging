param vmSize string = 'Standard_DS2_v2'

module storageMod '2_storage.bicep' = {
  name: 'storageMod'
}

module networkMod '3_networking.bicep' = {
  name: 'networkMod'
}

module firstVM '1_compute.bicep' = {
  name: 'firstVMDeployment'
  params:{
    vmSize: vmSize
    dataDiskId: storageMod.outputs.dataDiskOp_Id
    nicId:networkMod.outputs.nicOp_Id
  }
}


