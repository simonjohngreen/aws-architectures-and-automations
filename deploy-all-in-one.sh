aws cloudformation create-stack \
--stack-name One-Click-Centrail-Setup-Contrail-Commands-Deployes-K8s-Cluster \
--template-body file://deployers/Contrail-One-Click-Deployer-All-In-One.json \
--parameters \
ParameterKey=ContainerRegistryPassword,ParameterValue=${ContainerRegistryPassword} \
ParameterKey=ContainerRegistryUserName,ParameterValue=${ContainerRegistryUserName} 
