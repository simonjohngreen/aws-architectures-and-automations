#this stack is fully automated, it does not use fabric for provisioning
#this is required so I can remove the lo0.0 interface which would be dropped in transit aws to on premise
aws cloudformation create-stack \
  --stack-name SDN-GW-Brownfield-Automated \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/vMX-SDN-Gateway-Brownfield-Autonated.json \
  --parameters \
ParameterKey=idVPC,ParameterValue="vpc-0ea16152c63b68355"
