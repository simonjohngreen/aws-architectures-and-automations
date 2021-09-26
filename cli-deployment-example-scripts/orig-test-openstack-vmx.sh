aws cloudformation create-stack \
  --stack-name OpenStack-SDN-GW \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/vMX-SDN-Gateway.json \
  --parameters \
ParameterKey=SGSubnet1,ParameterValue="100.72.100.0/23" \
ParameterKey=SGSubnet2,ParameterValue="10.20.30.0/24" \
ParameterKey=SGSubnet3,ParameterValue="10.20.31.0/24" \
ParameterKey=SGSubnet4,ParameterValue="10.20.32.0/24" \
ParameterKey=idVPC,ParameterValue="vpc-0b544eb12e2ba8ff2" \
ParameterKey=idSDNGatewayPublicSubnet1,ParameterValue="subnet-082c1e76f99fc0085" \
ParameterKey=idControllersPrivateSubnet1,ParameterValue="subnet-03ffa548c4f10827b" \
ParameterKey=SDNGatewayFXP0PublicIP,ParameterValue="100.72.100.204" \
ParameterKey=SDNGatewayFXP0PublicIPSN,ParameterValue="26" \
ParameterKey=SDNGatewayAZ1PrivateIPGE000,ParameterValue="100.72.100.12" \
ParameterKey=SDNGatewayAZ1PrivateIPGE000SN,ParameterValue="26" \
ParameterKey=SDNGatewayAZ1PrivateIPGE001,ParameterValue="100.72.100.13" \
ParameterKey=SDNGatewayAZ1PrivateIPGE001SN,ParameterValue="26" \
ParameterKey=SDNGatewayPrivateSNGatewayIP,ParameterValue="100.72.100.193"
