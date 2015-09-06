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

- Step by step [aws-apc](./aws/aws-vpc.md) details.

### Create an AWS VPC Security Group

- Step by step [aws-security-group](./aws/aws-security-group.md) details.

### Create AWS Server Instance
- [aws-instance](./aws/aws-instance.md)

### Create AWS IP and DNS
- [aws-ip-dns](./aws/aws-ip-and-dns.md)

### AWS Login with SSH

- `ssh -v ubuntu@mandolin.ridesharemarket.com`
- `ssh -v ubuntu@52.76.79.143`
- `ssh -v ubuntu@ec2-52-76-79-143.ap-southeast-1.compute.amazonaws.com`

### Instance Configuration Management

- Update [kitchen/data_bags/network/prd_aws_ridesharemarket.json](./../app/kitchen/data_bags/network/prd_aws_ridesharemarket.json) with:
- AWS instance id
- AWS Public IP
- AWS Private IP
- Update developer workstation */etc/hosts*
- `../lib/network_hosts.rb | sudo tee -a /etc/hosts && sudo vi /etc/hosts`
- Bootstrap the server, which includes:
- apt-get autoremove.
- Copy in the chef secret key.
- Bootstrap the node with Chef and register with Chef Server 
- `./devops.rb server_bootstrap mandolin`
- Reboot the server and confirm boot up email received (sanity check plus reboot into any new linux kernel).
- `./devops.rb reboot --user ubuntu --hostname mandolin`

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
