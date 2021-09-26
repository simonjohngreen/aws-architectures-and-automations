**All in One Contrail 5.1 FRS plus Kubernetes build using the Contrail Command UI**

One Time Setup:

1. You need an AWS account. 
2. In your account you need to add in region Frankfurt an EC2 SSH key pair named OneClickKey1
3. You need to accept the commercial minimal CentosOS 7, free ami, link is here (takes ten minutes for AWS to process this) [Accept the Centos 7 AMI for Frankfurt](https://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce)
1.  You will need an account on the juniper contrail docker git repo hub.juniper.net/contrail (user and password)

How to deploy an all in one setup into your AWS account:
1.  Click this link to launch the CloudFormation stack into your account (Frankfurt)
2.  Get a coffee, it takes 5 minutes.
3.  Connect to the Contrail Command UI on https://[contrail-command-instance-public-ip]:9091
4. The IP's are also outputs in the CloudFormation stack.

What does it build: 
1.  AWS infrastructure including access over internet
2.  Contrail Command
2.  One bare metal server to then deploy from the contrail command UI, build a contrail+kubernetes all in one

![One-Click-Bare-Metal-Simulation-AllInOne](/uploads/cacfdc92422a561149842d74ba44ba82/One-Click-Bare-Metal-Simulation-AllInOne.jpg)


How do I use the Contrail Command UI to deploy Contrail plus Kubernetes once its up:
1.  Connect to the Contrail command UI https://[contrail-command-instance-public-ip]:9091
2.  Create -> Servers -> Credentials->add
    <br/>name=centos
    <br/>ssh user=root
    <br/>ssh password=EfrtGF5EDF_d54ERrf
    <br/>key=Centos
    <br/>->Create
3.  Create -> Servers -> Servers ->add
    <br>name=Contrailandk8master1
    <br/>mgmt ip=100.72.100.139
    <br/>Interface=ens5
    <br/>Credentials=centos
    <br/>->Create
4.  Click ->Next This is the Provisioning Manager Page
    <br/>Name: MyOnPremInAWSAllInOne (of whatever else you like)
    <br/>Container Registry:hub.juniper.net/contrail  
    Container Registry User Name:[your contrail registry user user name here]
    <br/>Container Registry Password: [your contrail registry password here]
    <br/>Contrail Version:5.1.0-0.38
    <br/>Domain Suffix: eu-central-1.compute.internal
    <br/>NTP Server: 17.253.108.253
    <br/>Default vRouter Gateway:100.72.100.129
    <br/>Encapsulation Priority: MPLSoUDP,MPLSoGRE,VxLAN
5.  Click -> This is the  xxx page
    <br/>Assign your one server by clicking it (it goes to the right)
6.  Click -> This is the  xxx page
    <br/>Change the orchestrator from Openstack to kubernetes
    Assign your one server by clicking it (it goes to the right)
7.  Click -> This is the  computes page
    <br/>Assign your one server by clicking it (it goes to the right)
    <br/>->
    <br/>->
    <br/>->
<br/>Your cluster will Deploy.
<br/>(current bug) it will fail on networking restart just rerun the deploy. Then it succeeds. 

Some screen shots:
![Screenshot---_2019-06-18_at_09.52.39](/uploads/4daa3da5908eaf2ea0784d684f86b057/Screenshot---_2019-06-18_at_09.52.39.png)
![Screenshot_2019-06-18_at_09.52.51](/uploads/1880f6a89f680a39dd9bc1dbf268db55/Screenshot_2019-06-18_at_09.52.51.png)
![Screenshot_2019-06-18_at_10.12.21](/uploads/de4c0ae0d921464df4dfcc8fc28e52e9/Screenshot_2019-06-18_at_10.12.21.png)

How do I connect to the cluster:
1.  For convenience the contrail command instance is configured as a NAT router. It provides access to everything. 
2.  for UI access to the contrail command UI https:[contrail command public ip]:9091
3.  for UI access to the contrail SDN UI https:[contrail command public ip]:8143
4.  for ssh access to the contrail command   ssh -I [your OneClickKey1 private key file] centos@[your contrail command public ip]
5.  for ssh access to the controller+compute node for ssh access to the contrail command   ssh -I [your OneClickKey1 private key file] -p 1139 centos@[your contrail command public ip]

Can I Secure it:
1.  The stack parameter UserLocation determines who can connect to it. 
2.  If you leave it blank I'll set it to 0.0.0.0/0 and the whole internet can connect.
3.  If you set it to your laptop ip address x.x.x.x/32 only you can connect to it, its secured.
4.  You can change the rules in the contrail command security group, add your own ip's etc.

Can I use this for production:
1.  Sorry it's just to make POCs simpler







     
  
