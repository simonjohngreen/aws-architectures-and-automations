#this is for the openstack step 2 from my youtibe video
#I use fabric which will only work within AWS or within on premose, it'll not work DC to on preemise
aws cloudformation create-stack \
  --stack-name OpenStack-SDN-GW-Brownfield \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/vMX-SDN-Gateway-Brownfield.json \
  --parameters \
ParameterKey=SGSubnet1,ParameterValue="100.72.100.0/23" \
ParameterKey=idVPC,ParameterValue="vpc-09a538ff3ffc201fd" \
ParameterKey=idSDNGatewayPublicSubnet1,ParameterValue="subnet-07b1d905d1b380cb7" \
ParameterKey=idControllersPrivateSubnet1,ParameterValue="subnet-0f71f7f3504accdee" \
ParameterKey=idControllersPrivateSubnetRouteTable1,ParameterValue="rtb-022a4a6c6fba3a535" \
ParameterKey=idControllersSecurityGroup,ParameterValue="sg-0d635d8f4f88a481c" \
ParameterKey=SDNGatewayFXP0PublicIP,ParameterValue="100.72.100.204" \
ParameterKey=SDNGatewayFXP0PublicIPSN,ParameterValue="26" \
ParameterKey=SDNGatewayAZ1PrivateIPGE000,ParameterValue="100.72.100.12" \
ParameterKey=SDNGatewayAZ1PrivateIPGE000SN,ParameterValue="26" \
ParameterKey=SDNGatewayAZ1PrivateIPGE001,ParameterValue="100.72.101.4" \
ParameterKey=SDNGatewayAZ1PrivateIPGE001SN,ParameterValue="26"
