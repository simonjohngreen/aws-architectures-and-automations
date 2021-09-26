**Deploy an HA Contrail SDN controller cluster across three AZs**

--------------

22-11-2019 Status: Updated to current Contrail release 1911-31

--------------

One Time Setup:

1. You need an AWS account. Login to the AWS console with your browser.
2. In your AWS account console you need to an EC2 SSH key pair named "ContrailKey" within the region Frankfurt
3. You will need to accept the commercial minimal CentosOS 7 free ami, The link is here (it takes ten minutes for AWS to process this) [Accept the Centos 7 AMI for Frankfurt](https://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce)
1.  You will need an account on the juniper contrail docker registry hub.juniper.net/contrail (user and password) in order to use our contrail SDN software.

How to deploy:
1.  Click this link to launch the CloudFormation stack into your account (Frankfurt)
[<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=Contrail-HA-Controller&templateURL=https://s3.amazonaws.com/contrail-one-click-deployers/Contrail-HA-Controller.json)
<br/>**Note: if you right click and copy this link, then share it with your customers via email. It will work for them as well**
<br/>->NEXT
  <br/>**complete the field ContainerRegistryUserName** (this is your juniper docker registry user name)
  <br/>**complete the field ContainerRegistryPassword** (this is your juniper docker registry password)
<br/>->NEXT
<br/>->NEXT
<br/>->Deploy Stack

<br/>Note: All fields can be changed, but for the first run we suggest you go with the defaults.
<br/>Note: For production deployments you should change the flavour from m4.2xlarge to m4.4xlarge

2.  Get a coffee, it typically takes 6 minutes (3 for the stack to complete, 3 for Contrail Command to build)
3.  Once the stack completes the CloudFormation outputs tab will show you how to access the hosts and Contrail Command UI.

What does it build: 
1.  AWS infrastructure across three availability zones, including OAM access over internet
2.  Contrail Command
2.  Three bare metal servers to configure with the contrail command UI, in the steps below we will build a Kubernetes Master with Contrail integrated as the HA CNI. 

![One-Click-Bare-Metal-Simulation-All-In-One](images/HA-Controller.png)

If you set "DeployHighlyAvailable=false" then it will deploy without HA

<img src="images/non-HA-Controller.png" width="200">

-----------------------------
-----------------------------
<br/>Patch added: 19th November 2019 for release 1910.
<br/>this issue is fixed in release 1911. This patch is not required for this release.

Upstream: pip2 install docker-compose was broken this week. 
The following patch ran as root on the contrail command instance will fix this. Without the patch the cluster deploy will fail as follows "jsonschema 3.2.0 has requirement six>=1.11.0, but you'll have six 1.9.0 which is incompatible."

docker exec -it $(docker ps -f "name=contrail_command" --format {{.ID}}) /usr/bin/sed -i '/^    name: docker-compose/a \ \ \ \ version: 1.24.1' /tmp/contrail-ansible-deployer/playbooks/roles/instance/tasks/install_software_Linux.yml

-----------------------------
-----------------------------


Build steps follow:

1.  Connect to the Contrail command UI https://[contrail-command-instance-public-ip]:9091
<br/>user=admin password=contrail123 (the CloudFormation outputs tab will give you the full OAM access links)
2.  -> Credentials->add
    <br/>name=centos
    <br/>ssh user=root
    <br/>ssh password=EfrtGF5EDF_d54ERrf (unless you changed the value prior to deploying)
    <br/>->ADD
3.  ->Servers->ADD
    <br>name=ContrailController1
    <br/>mgmt ip=100.72.100.11
    <br/>Interface=ens3
    <br/>Credentials=centos
    <br/>->Create
3.  ->Servers->ADD
    <br>name=ContrailController2
    <br/>mgmt ip=100.72.100.74
    <br/>Interface=ens3
    <br/>Credentials=centos
    <br/>->Create
3.  ->Servers->ADD
    <br>name=ContrailController3
    <br/>mgmt ip=100.72.100.138
    <br/>Interface=ens3
    <br/>Credentials=centos
    <br/>->Create
4.  Click ->Next This is the Cloud Manager Page
    <br/>Cluster Name=HAContrailController (or any name you like)
    <br/>Container Registry=hub.juniper.net/contrail  (default)
    Container Registry User Name:[your contrail registry user user name here]
    <br/>Container Registry Password: [your contrail registry password here]
    <br/>Contrail Version=1911.31
    <br/>Domain Suffix=eu-central-1.compute.internal
    <br/>NTP Server=169.254.169.123
    <br/>Default vRouter Gateway=100.72.100.1
    <br/>Encapsulation Priority=MPLSoUDP,MPLSoGRE,VxLAN
5.  Click ->NEXT This is the  Control Nodes page
    <br/>tick the "High Availability Mode" box
    <br/>Assign your three controller servers by clicking the arrow (they move to the right)
6.  Click ->NEXT This is the Orchestrator Nodes page
    <br/>Change the orchestrator from Openstack to kubernetes
    Assign your three controller servers by clicking the arrow (it goes to the right)
7.  Click ->NEXT This is the Computes Nodes page. Nothing to complete here, do not assign a server.
8.  Click ->NEXT This is Contrail Service Nodes. Nothing to complete here, do not assign a server.
9.  Click ->NEXT  This is the Appformix Nodes. Nothing to complete here, do not assign a server.
10. Click ->NEXT You are on the Summary Page 
11. Click ->Provision   
<br/>Your cluster will Deploy. After approx 6 minutes it should say finished successfully. Add a couple of minutes for the UI.
<br/>Now click ->Proceed to be redirected the login page Login
<br/>This time select your cluster MyOnPremAllInOne user=admin password=contrail123 
<br/>You are done. The portal will show up in a minute of two. Go play.

<br/>Note: at this point CoreDNS will not come up, this is expected as we have no compute nodes yet.
<br/>Note: Contrail Command is currently not deploying HA for Kubernetes masters (the third controller is assigned the K8Master), it does assign three nodes for Contrail. This is a Contrail Command limitation.


How to secure OAM access:
1.  The stack parameter UserLocation determines who can connect to it. 
2.  If you leave it blank we will allow access from 0.0.0.0/0,  the whole of the internet.
3.  If you set it to your laptop ip address x.x.x.x/32 only you can connect to it, its secured within the public SG.
4.  You can also manually change the rules in the contrail command AWS security group.

What Next:
1. This controller cluster can now be stretched out to worker nodes in your on-premise DC, AWS, GCP, Azure etc.
2.  The next stack will create an VPC with minion worker nodes in AWS.
