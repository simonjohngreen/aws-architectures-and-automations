#I've tried the following releases to see if there is a change in the behaviour as hinteed in the email
#juniper contrail 2008.13 vrouter api replies with 404, kube-manager errors towards k8s api 
#tf master-latest taken on 120820: controller down, device manager broken by ztp code so removed the pod and redeployed. vrouter api replies with 404, kube-manager errors towards k8s api
#tf master.1288 is about a month ago vrouter 404, kube-manager errors towards k8s api
#tf master.1264 2 months ago, vrouter 404, kube-manager errors towards k8s api
#tf master.1229 3 months ago. contrail and kubernetes worked fine. pods got an overlay ip's. but host could not ping the pods without fabric forwarding, same as on 2005.
#I also tried manually injecting a pod route on the hosts, it had no impact.
aws cloudformation create-stack \
  --capabilities CAPABILITY_IAM \
  --stack-name Tungston-k8s-Federated-Stack2-AllInOne \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/Tungston-k8s-Federated-Stack2.json \
  --parameters \
ParameterKey=ContainerRegistryUserName,ParameterValue="[login]" \
ParameterKey=ContainerRegistryPassword,ParameterValue="[password]" \
ParameterKey=idPublicSubnet1,ParameterValue="subnet-0c2ac4fb4c87d08c5" \
ParameterKey=idPrivateSubnet1,ParameterValue="subnet-05ea75512cd129260" \
ParameterKey=idVPC,ParameterValue="vpc-07863cc4808570d8c" \
ParameterKey=NumberOfClusters,ParameterValue="1" \
ParameterKey=ContainerRegistryTag,ParameterValue="master-latest"
