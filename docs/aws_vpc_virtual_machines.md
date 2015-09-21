## Requirements

### AWS - Amazon Web Services

- AWS IAM - Identity and Access Management

An active IAM account with developer group access permissions.

The Access Key ID and Access Key Secret will be used for the AWS CLI.

- The AWS Command Line Interface unified tool to manage AWS services.
- [AWS CLI Install Docs](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [AWS CLI Usage Docs](http://docs.aws.amazon.com/cli/latest/index.html)

Post install `~/.aws/` should be set up with config and credentials files.

Check the `~./aws/config` file is set to the correct aws region.

The [jq](https://stedolan.github.io/jq/) binary is also required.

### Chef Server Account

An active and configured account with [Chef](https://manage.chef.io/login).

Review the [kitchen/.chef/knife.rb](../app/kitchen/.chef/knife.rb) file configuration details.

Make sure the referenced files are in place and/or update as required.

### Chef Server Data Bags

Network JSON configuration data needs to be kept in sync locally and with the remote Chef server.

- `cd app/kitchen`
- `knife data bag create network`
- `knife data bag from file network data_bags/network/prd_aws_ridesharemarket.json`

Encrypted application secrets need to be kept in sync locally and with the remote Chef server.

- `knife data bag create secrets`
- `knife data bag from file secrets data_bags/secrets/secrets.json`

Users data_bag need to be kept in sync locally and with the remote Chef server.

- Note: Currently not used as all apps are 'Dockerized' (but details left here for now).
- `knife data bag create users`
- `knife data bag from file secrets data_bags/users/rsm-data.json`

### Chef Server Cookbooks

- `knife cookbook upload --all`
- See the [chef_server document](./chef_server.md) for more usage details.

### Create an AWS VPC

- [aws-apc](./aws/aws-vpc.md)

### Create AWS VPC Security Groups

- [aws-security-groups](./aws/aws-security-groups.md)

### Create AWS VPC Subnets

- [aws-apc-public-subnet](./aws/aws-vpc-public-subnet.md)
- [aws-apc-private-subnet](./aws/aws-vpc-private-subnet.md)

### Create Internet Gatway and Route tables

- [aws-vpc-internet-gateway.md](./aws/aws-vpc-internet-gateway.md)
- [aws-vpc-public-route-table.md](./aws/aws-vpc-public-route-table.md)
- [aws-vpc-private-route-table.md](./aws/aws-vpc-private-route-table.md)


### Create AWS Public Subnet Server Instance
- [aws-public-instance](./aws/aws-instance-public-subnet.md)

### Create AWS IP and DNS
- [aws-ip-dns](./aws/aws-ip-and-dns.md)

### AWS Login with SSH

After a few minutes the new instance will boot up, upgrade, then reboot.

- `ssh -vA ubuntu@$VPC_PUBLIC_IP`
- `ssh -vA ubuntu@mandolin.ridesharemarket.com`

### Create a route to the internet, via the NAT instance, for the private subnet

- [aws-vpc-private-subnet-route](./aws/aws-vpc-private-subnet-route.md)

### Create AWS Private Subnet Server Instance
- [aws-instance](./aws/aws-instance-private-subnet.md)


### Instance Configuration Management

Update [kitchen/data_bags/network/prd_aws_ridesharemarket.json](./../app/kitchen/data_bags/network/prd_aws_ridesharemarket.json) with:

- AWS instance id
- AWS Public IP
- AWS Private IP
- `aws ec2 describe-instances --instance-id $VPC_BASTION_INSTANCE | grep 'InstanceId\|PublicIpAddress\|PrivateIpAddress'`
- `aws ec2 describe-instances --instance-id $VPC_DB_INSTANCE | grep 'InstanceId\|PublicIpAddress\|PrivateIpAddress'`

Update developer workstation */etc/hosts*

- `../lib/network_hosts.rb | sudo tee -a /etc/hosts && sudo vi /etc/hosts`

Update Chef Server with network data bag

- `knife data bag from file network data_bags/network/prd_aws_ridesharemarket.json` 

## Bootstrap Bastion Server

**Bootstrap includes:**

- apt-get autoremove.
- Copy in the chef secret key.
- Bootstrap the node with Chef and register with Chef Server
 
**AWS Public Subnet**

- `./devops.rb server_bootstrap mandolin`
- Reboot the server and confirm boot up email received (sanity check plus reboot into any new linux kernel).
- `./devops.rb reboot --user ubuntu --hostname mandolin`

## Configure Local OpenVPN

- [vpn](./vpn.md)

## Bootstrap Servers

**Bootstrap includes:**

- apt-get autoremove.
- Copy in the chef secret key.
- Bootstrap the node with Chef and register with Chef Server

**AWS Private Subnet**

- `./devops.rb server_bootstrap trumpet --lan yes`
- Reboot the server and confirm boot up email received (sanity check plus reboot into any new linux kernel).
- `./devops.rb reboot --user ubuntu --hostname lan.trumpet`

## Configure Chef Server run list

- [Chef Server Run List](chef_server.md)

## Configure Jenkins CI

- [Jenkins CI](jenkins-ci.md)

## Application Build and Deploy

- [Deployment](deployment.md)

## Destroy

- Destroy Digital Ocean instance.
- Delete Chef Node.
- Delete Chef Client.
- Remove .ssh/known_hosts entries.
- `./devops.rb server_delete mandolin`
- `./devops.rb server_delete trumpet`
