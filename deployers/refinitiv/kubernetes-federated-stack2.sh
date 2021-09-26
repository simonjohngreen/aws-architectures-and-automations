#!/bin/bash
#### DNS SERVER OPTIONS
## Refinitiv Bind resolver 164.57.211.253
## AWS own DNS server dnsmasq 10.186.217.196
## AWS public DNS 169.254.169.253

## AWS NTP server: 169.254.169.123

export DNSServer="10.186.217.196"


set -e
aws s3 cp deployers/Contrail-k8s-Federated-Stack2.json s3://reflex-incubator/os-contrail/contrail-one-click-deployers/Contrail-k8s-Federated-Stack2.json  \
  --profile reflex-dev-admin --region eu-central-1

# aws s3 cp ../Contrail-OpenShift-BrownfieldStretch-worker.json s3://reflex-incubator/os-contrail/contrail-one-click-deployers/Contrail-OpenShift-BrownfieldStretch-worker.json  \
#    --profile reflex-dev-admin --region eu-central-1

#aws s3 cp ../Contrail-OpenShift-BrownfieldStretch-worker.json s3://reflex-incubator/os-contrail/contrail-one-click-deployers/Contrail-OpenShift-BrownfieldStretch-worker.json  \
#  --profile reflex-dev-admin --region eu-west-1

# spin-up worker ec2 in eu-west-1
# region: eu-west-1
# vpc:vpc-0511b8e3e88bfb8a4
# subnet: subnet-092c0ec84bec57789
# ip: 10.186.218.202

aws cloudformation create-stack \
  --profile reflex-dev-admin \
  --region eu-central-1 \
  --capabilities CAPABILITY_IAM \
  --stack-name Kubernetes-Federated-Stack2-AllInOne \
  --disable-rollback \
  --template-url https://reflex-incubator.s3-us-west-1.amazonaws.com/os-contrail/contrail-one-click-deployers/Contrail-k8s-Federated-Stack2.json \
  --parameters \
ParameterKey=SiteName,ParameterValue="k8sFederation" \
ParameterKey=ContainerRegistryUserName,ParameterValue="JNPR-FieldUser104" \
ParameterKey=ContainerRegistryPassword,ParameterValue="PNMUJ7hVnS5ETBysrdWZ" \
ParameterKey=idVPC,ParameterValue="vpc-007bb8d618d4c88ee" \
ParameterKey=idPublicSubnet1,ParameterValue="subnet-046aa02ef91ca83d1" \
ParameterKey=idPrivateSubnet1,ParameterValue="subnet-0e9823c7c50c4484e" \
ParameterKey=NodeMTU,ParameterValue="9001" \
ParameterKey=DeployContrailCommand,ParameterValue="true" \
ParameterKey=DebugLogs,ParameterValue="false" \
ParameterKey=TestPod,ParameterValue="true" \
ParameterKey=NumberOfClusters,ParameterValue="2"
