aws cloudformation create-stack \
  --stack-name OpenShift-Greenfield \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/Contrail-OpenShift-Greenfield.json \
  --parameters \
ParameterKey=ContainerRegistryUserName,ParameterValue="[login]" \
ParameterKey=ContainerRegistryPassword,ParameterValue="[password]" \
ParameterKey=RedHatAccountUserName,ParameterValue="[login]" \
ParameterKey=RedHatAccountPassword,ParameterValue="[password]" \
ParameterKey=RedHatSubscriptionPoolID,ParameterValue="[pool id]" \
ParameterKey=SGSubnet2,ParameterValue="10.20.30.0/24" \
ParameterKey=SGSubnet3,ParameterValue="10.20.31.0/24" \
ParameterKey=SGSubnet4,ParameterValue="10.20.32.0/24" \
ParameterKey=PodIPAM,ParameterValue="10.20.35.0/24" \
ParameterKey=ServiceIPAM,ParameterValue="10.20.36.0/24"
