param vmSize string = 'Standard_DS2_v2'

module firstVM '1_compute.bicep' = {
  name: 'firstVMDeployment'
  params:{
    vmSize: vmSize
  }
}


