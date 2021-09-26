aws cloudformation create-stack \
  --stack-name OpenShift-Brownfield \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/Contrail-OpenShift-Brownfield.json \
  --parameters \
ParameterKey=ContainerRegistryUserName,ParameterValue="xxxxxxx" \
ParameterKey=ContainerRegistryPassword,ParameterValue="xxxxxxx" \
ParameterKey=RedHatAccountUserName,ParameterValue="xxxxxxx" \
ParameterKey=RedHatAccountPassword,ParameterValue="xxxxxxx" \
ParameterKey=RedHatSubscriptionPoolID,ParameterValue="xxxxxxx" \
ParameterKey=idContrailCommandPublicSubnet1,ParameterValue="subnet-00e02af1c495cc3ea" \
ParameterKey=idControllersPrivateSubnet1,ParameterValue="subnet-06f4f9b86b2fcfebe" \
ParameterKey=idControllersPrivateSubnet2,ParameterValue="subnet-07ac24ae57e7c47b3" \
ParameterKey=idControllersPrivateSubnet3,ParameterValue="subnet-01ee100098dc4fe1b" \
ParameterKey=idWorkersPrivateSubnet1,ParameterValue="subnet-06f4f9b86b2fcfebe" \
ParameterKey=idWorkersPrivateSubnet2,ParameterValue="subnet-07ac24ae57e7c47b3" \
ParameterKey=idWorkersPrivateSubnet3,ParameterValue="subnet-01ee100098dc4fe1b" \
ParameterKey=idVPCCONTROLLERS,ParameterValue="vpc-008ead9e50c0a8a7f" \
ParameterKey=idVPCWORKERS,ParameterValue="vpc-008ead9e50c0a8a7f" \
ParameterKey=SGSubnet2,ParameterValue="10.20.30.0/24" \
ParameterKey=SGSubnet3,ParameterValue="10.20.31.0/24" \
ParameterKey=SGSubnet4,ParameterValue="10.20.32.0/24"
