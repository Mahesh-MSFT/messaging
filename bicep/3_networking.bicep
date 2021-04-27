resource nsg 'Microsoft.Network/networkSecurityGroups@2020-11-01'= {
  name: 'mqQueueMgr-VM-nsg'
  location: resourceGroup().location
  properties:{
    securityRules:[
      {
        name: ''
        properties: {
            description: 'description'
            protocol: 'Tcp'
            sourcePortRange: '*'
            destinationPortRange: '3389'
            sourceAddressPrefix: '*'
            destinationAddressPrefix: '*'
            access: 'Allow'
            priority: 100
            direction: 'Inbound'
          }
        }
    ]
  }
}

resource vNet 'Microsoft.Network/virtualNetworks@2020-11-01' ={
  name: 'mqQueueMgr-VM-VirtualNetwork'
  location: resourceGroup().location
  properties:{
    addressSpace:{
      addressPrefixes:[
        '10.0.0.0/16'
      ]
    }
    subnets:[
      {
        name: 'mqQueueMgr-VM-VirtualNetwork-Subnet'
        properties:{
          addressPrefix:'10.0.0.0/24'
          networkSecurityGroup:{
            id: nsg.id
          }
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties:{
          addressPrefix: '10.0.1.0/27'
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2020-11-01'={
  name: 'mqQueueMgr-VM-NetworkInterface'
  location: resourceGroup().location

  properties:{
    ipConfigurations:[
      {
        name: 'ipConfig1'
        properties:{
          privateIPAllocationMethod:'Dynamic'
          subnet:{
            id: nsg.id
          }
        }
      }
    ]
  }
}

output nicOp_Id string = nic.id
