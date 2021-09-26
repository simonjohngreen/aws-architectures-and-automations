aws cloudformation create-stack \
  --stack-name SDN-GW-Greenfield-Automated \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/contrail-one-click-deployers/test-vMX-SDN-Gateway-Greenfield-Automated.json 
