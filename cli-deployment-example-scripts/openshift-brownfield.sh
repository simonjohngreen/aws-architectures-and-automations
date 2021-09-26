aws cloudformation create-stack \
  --stack-name OpenShift-Brownfield \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/Contrail-OpenShift-Brownfield.json \
  --parameters \
ParameterKey=ContainerRegistryUserName,ParameterValue="[login]" \
ParameterKey=ContainerRegistryPassword,ParameterValue="[password]" \
ParameterKey=RedHatAccountUserName,ParameterValue="[login]" \
ParameterKey=RedHatAccountPassword,ParameterValue="[password]" \
ParameterKey=RedHatSubscriptionPoolID,ParameterValue="[poolid]" \
ParameterKey=idContrailCommandPublicSubnet1,ParameterValue="subnet-07c61ad76c2b8793f" \
ParameterKey=idControllersPrivateSubnet1,ParameterValue="subnet-0061e8634ba522307" \
ParameterKey=idControllersPrivateSubnet2,ParameterValue="subnet-06c3126eedd949437" \
ParameterKey=idControllersPrivateSubnet3,ParameterValue="subnet-04d4a9733da984200" \
ParameterKey=idWorkersPrivateSubnet1,ParameterValue="subnet-0061e8634ba522307" \
ParameterKey=idWorkersPrivateSubnet2,ParameterValue="subnet-06c3126eedd949437" \
ParameterKey=idWorkersPrivateSubnet3,ParameterValue="subnet-04d4a9733da984200" \
ParameterKey=idVPCCONTROLLERS,ParameterValue="vpc-0774ce7ce392fab90" \
ParameterKey=idVPCWORKERS,ParameterValue="vpc-0774ce7ce392fab90" \
ParameterKey=SGSubnet2,ParameterValue="10.20.30.0/24" \
ParameterKey=SGSubnet3,ParameterValue="10.20.31.0/24" \
ParameterKey=SGSubnet4,ParameterValue="10.20.32.0/24" \
ParameterKey=PodIPAM,ParameterValue="10.20.35.0/24" \
ParameterKey=ServiceIPAM,ParameterValue="10.20.36.0/24" \
ParameterKey=PodIPAM,ParameterValue="10.20.35.0/24" \
ParameterKey=ServiceIPAM,ParameterValue="10.20.36.0/24" \
ParameterKey=NodeMTU,ParameterValue="9000"
