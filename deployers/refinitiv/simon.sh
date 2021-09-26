aws cloudformation create-stack \
  --region eu-west-1 \
  --capabilities CAPABILITY_IAM \
  --stack-name Kubernetes-Federated-Stack2-AllInOne \
  --disable-rollback \
  --template-url https://reflex-incubator.s3-us-west-1.amazonaws.com/os-contrail/contrail-one-click-deployers/Contrail-k8s-Federated-Stack2.json \
  --parameters \
ParameterKey=SiteName,ParameterValue="k8sFederation" \
ParameterKey=AvailabilityZone1,ParameterValue="eu-central-1a" \
ParameterKey=ContainerRegistryUserName,ParameterValue="JNPR-FieldUser104" \
ParameterKey=ContainerRegistryPassword,ParameterValue="PNMUJ7hVnS5ETBysrdWZ" \
ParameterKey=idVPC,ParameterValue="vpc-037ceaca64c6428b5" \
ParameterKey=idPublicSubnet1,ParameterValue="subnet-03e5902443a424933" \
ParameterKey=idPrivateSubnet1,ParameterValue="subnet-0088390d56c9154cf" \
ParameterKey=NodeMTU,ParameterValue="9001" \
ParameterKey=DeployContrailCommand,ParameterValue="true" \
ParameterKey=DebugLogs,ParameterValue="false" \
ParameterKey=TestPod,ParameterValue="true" \
ParameterKey=NumberOfClusters,ParameterValue="2"
