#this one is to large for a local launch now. the limitation is removed once its been pushed to S3 and launched as a one click deployr, in this case it can be huge.
aws cloudformation create-stack \
--stack-name One-Click-Centrail-Setup-Contrail-Commands-Deployes-K8s-Cluster \
--template-body file://deployers/Contrail-One-Click-Deployer-Three-VPC.json \
--parameters \
ParameterKey=ContainerRegistryPassword,ParameterValue=${ContainerRegistryPassword} \
ParameterKey=ContainerRegistryUserName,ParameterValue=${ContainerRegistryUserName} 
