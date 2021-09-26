**How to Add a Server into any existing AWS VPC and Subnet then configure it as a K8S Minion into an existing cluster using the Contrail Command UI**

**This is a useful stack for customers who have their own transmission built up in AWS (Direct connect GW, Transit GW, VPC gateway etc.). So cannot use the Multi Cloud deployer which focuses on using MCGWs today**
<br/>
<br/>**This stack will deploy a server into any VPC and Subnet, prepare it for contrail comand**
<br/>**Then the server can be defined in Contrail Command UI as a vRouters and K8minions**

1.  Click this link to launch the CloudFormation stack into your account (Frankfurt)
[<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=Contrail-One-Click-Add-a-Server&templateURL=https://s3.amazonaws.com/contrail-one-click-deployers/Contrail-One-Click-Deployer-Add-a-Server.json)
<br/>**Note: if you right click and copy this link and share it with your customers it will work for them as well.**
<br/>->NEXT
  <br/>**complete the field AvailabilityZone** (this is the availability zone to place the instance)
  <br/>**complete the field InstanceIPAddress** (This is the IP address the instance should take)
  <br/>**complete the field InstanceName** (this is the name you want for your new instance)
  <br/>**complete the field KeyName** (this is the EC2 key to use for ssh, use the drop down, the default is OneClickKey1)
 <br/>**complete the field SubnetID** (this is existing id of the subnet you would ike your instance deployed into)
<br/>**complete the field VPCID** (this is your existing VPC id that your instance should be deployed into)
<br/>->NEXT
<br/>->NEXT
<br/>->Deploy Stack
<br/>2.  Get a coffee, it takes 3 minutes to deploy the server.
<br/>3.  Once the stack completes you will get this...
![One-Click-Bare-Metal-Simulation-All-In-One](images/BYOT-brown-field-adding-a-server.png)
<br/>4.  Connect to the Contrail command UI https://[contrail-command-instance-public-ip]:9091
<br/>select the existing cluster id, user=admin password=contrail123 (unless you changed the values prior to deploying)
<br/>5.  ->Servers->Create
    <br/>name=[put the name of the server here, it can be any name in the UI, it doesn't have to be the hostname]
    <br/>mgmt ip=[put the ip of the server here, its in the stack output]
    <br/>Interface=ens5
    <br/>Credentials=centos
    <br/>->Create
<br/>6. Click Cluster->[cluster name]->Cluster Nodes->Compute Nodes->Add
    <br/>click the server you just added to move it right
    <br/>change the router GW ip from the default to the subnets GW (first IP in the subnet)
    <br/>->enroll server
<br/>7.Give it ten minutes to add the server (coffee). 
<br/>If you want to monitor the deployment then ssh into the contrail command instances and execute "docker exec contrail_command tail -f /var/log/ansible.log"
<br/>
<br/>Once its ready the cluster view will show an additional compute, for example. [add screen shot]
<br/>
<br/>In Kubernetes you will see the new minion with "kubectl get nodes"
<br/>
<br/>As you now have more than one node, if you have not already, then you should run this patch to ensure your apps do not get placed on the master.
<br/>*******************************************
<br/>**patch to fix CoreDNS and pod placement:**
<br/>A default Kubernetes setup may place CoreDNS and other pods on the master node where they will fail to start. The following patch will ensure they run in SDN overlay on the <br/>k8minions. Run the following command on the k8master as root.
<br/>**kubectl -n kube-system get deployment coredns -o yaml | sed '/- effect\: NoSchedule/d' | sed '/key\: node-role.kubernetes.io\/master/d' | kubectl apply -f -**
<br/>**kubectl taint node ip-100-72-100-139.eu-central-1.compute.internal node-role.kubernetes.io/master=true:NoSchedule**
<br/>**kubectl get pods -n kube-system -oname |grep coredns |xargs kubectl delete -n kube-system**
<br/>*******************************************
<br/>Can I Secure it:
<br/>1. This stack will add a security group for the new instance. 
<br/>2. The stack parameter SGSubnet1 will by default add an SG rule to allow all inbound traffic and ports towards this server. You can change this subnet and its port, SGSubnet1 SgTcpPort1 , to something more specific in order to lock down the server.
<br/>2.  The parameters SGSubnet2,3,4 will if left blank do nothing. If populated along with SgTcpPort2,3,4 will add an inbound tcp rule for the specified subnet and port.
<br/>3. A port specified as -1 in SGSubnet1,2,3,4 will allows all ports, 
  
 
