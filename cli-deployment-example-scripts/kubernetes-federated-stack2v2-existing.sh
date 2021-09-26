aws cloudformation create-stack \
  --capabilities CAPABILITY_IAM \
  --stack-name Kubernetes-Federated-Stack2-AllInOne \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/Contrail-k8s-Federated-Stack2v2.json \
  --parameters \
ParameterKey=ContainerRegistryUserName,ParameterValue="[login]" \
ParameterKey=ContainerRegistryPassword,ParameterValue="[password]" \
ParameterKey=idPublicSubnet1,ParameterValue="subnet-03e5902443a424933" \
ParameterKey=idPrivateSubnet1,ParameterValue="subnet-0088390d56c9154cf" \
ParameterKey=idVPC,ParameterValue="vpc-037ceaca64c6428b5" \
ParameterKey=NumberOfClusters,ParameterValue="2" \
ParameterKey="ExternaldnsCreateZone",ParameterValue="false"
