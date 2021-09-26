**Deploy Contrail Command R1912 within your AWS account**

One Time Setup:

1. You need an AWS account. Login to the AWS console with your browser.
2. In your account you need to add in region Frankfurt an EC2 SSH key pair named OneClickKey1
3. You need to accept the commercial minimal CentosOS 7, free ami, link is here (takes ten minutes for AWS to process this) [Accept the Centos 7 AMI for Frankfurt](https://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce)
1.  You will need an account on the juniper contrail docker registry hub.juniper.net/contrail (user and password)

How to deploy Contrail Command in your AWS account:
1.  Click this link to launch the CloudFormation stack into your account (Frankfurt)
[<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=Contrail-Command-In-AWS&templateURL=https://s3.amazonaws.com/contrail-one-click-deployers/Contrail-One-Click-Deployer-Contrail-Command-on-AWS.json)

<br/>**Note: if you right click and copy this link and share it with your customers it will work for them as well.**
<br/>->NEXT
  <br/>**complete the field ContainerRegistryUserName** (this is your juniper docker registry user name)
  <br/>**complete the field ContainerRegistryPassword** (this is your juniper docker registry user password)
  <br/>**We recommend changing the field UserLocation fro 0.0.0.0/0 to the x.x.x.x/32 IP address of your laptop for controller UI access)
  <br/>**Change field OnPremiseSubnetCIDR from 10.20.30.0/16 to the subnet that will be able to access the instance from your on premise DC. The instance SG allows all traffic into the instance from this subnet over internet as well as from your DC, so please bear that in mind. If you are concerned then you can remove the public EIP from the stack and access only via your private DC and AWS gateway)
<br/>->NEXT
<br/>->NEXT
<br/>->Deploy Stack

2.  Get a coffee, it takes 5 minutes (2 for the stack to complete, 3 for the build and Contrail Command UI to appear)
3.  Once the stack completes the CloudFormation outputs tab will show you how to access the hosts and UI.

What does it build: 
1.  In the selected region create a VPC, networks, SGs, route tables, routes and EIPs. 
2.  Deploys and build Contrail Command

Note: Routing
Contrail Command has two interfaces, 
    1) a public one the you use to access the UI over internet. It uses an internet gateway and an SG rule to control access.
    2) a private one to connect to your AWS gateway (any AWS gateway will work). 

The Contrail Command OS default route will point towards the public internet nic.
A Contrail Command static route towards the private subnet, then over your AWS gateway and DC. This subnet is specified in the stack as you deploy it. 
All unknown traffic will route towards internet from the Contrail Command instance. 
If you look inside the stack you will see how I add the static routes and you add your own as well.

![One-Click-Bare-Metal-Simulation-All-In-One](../images/ContrailCommand.png)

How do I use the Contrail Command UI to deploy Contrail plus Kubernetes once its up:
1.  Connect to the Contrail command UI https://[contrail-command-instance-public-ip]:9091
<br/>user=admin password=contrail123 (unless you changed the value prior to deploying)

How do I connect to the cluster: (check the CloudFormation outputs tab)
1.  for UI access to the contrail command UI https://[contrail-command-public-ip]:9091
2.  for ssh access to the contrail command ssh -i [your OneClickKey1 private key file] centos@[contrail-command-public-ip]

Can I Secure it:
1.  The stack parameter UserLocation determines who can connect to it. 
2.  If you leave it blank I'll set it to 0.0.0.0/0 and the whole internet can connect to it.
3.  If you set it to your laptop ip address x.x.x.x/32 then only you can connect to it, its secured.
4.  You can change the rules in the contrail command security group, add your own ip's etc.
5. The DC subnet is also opened up for inbound traffic. If you are concerned about this then delete the EIP and access the instance only via the private network over your gateway connection.

What Next:
1.  Use it as you would on premise. 
2.  For example: Connect your direct connect gateway to the region and use it normally. 
3. To get the bgp routes to propagate to/from the on premise you will need to change the Private Route table propagate tab to yes. I cannot do this for you as it needs a gateway provisioned first. 

Note: You can change the region parameter, but will then need to also change the ami parameter and sign off on the Tc&Cs. 

Note: Most fields can be changed, we recommend you deploy with the defaults first run. 

 

