echo "all parameters are optional in this stack"
aws cloudformation create-stack \
  --stack-name Kubernetes-Federated-Stack1-VPC \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/Contrail-k8s-Federated-Stack1.json \
  --parameters \
ParameterKey=VPCCIDR1,ParameterValue="100.72.100.0/22" \
ParameterKey=PrivateSubnetCIDR1,ParameterValue="100.72.100.0/24" \
ParameterKey=PrivateSubnetCIDR2,ParameterValue="100.72.101.0/24" \
ParameterKey=PrivateSubnetCIDR3,ParameterValue="100.72.102.0/24" \
ParameterKey=PublicSubnetCIDR1,ParameterValue="100.72.103.0/24" \
ParameterKey=AvailabilityZone1,ParameterValue="eu-west-1a" \
ParameterKey=AvailabilityZone2,ParameterValue="eu-west-1b" \
ParameterKey=AvailabilityZone3,ParameterValue="eu-west-1c" \
ParameterKey=SiteName,ParameterValue="k8sFederation"
