# AWS VPC Public Subnet Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create public subnet (an associated route table will be created automatically)
- `aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24`

- From the command output, save/export the **SubnetId** to en environment variable
- `export VPC_PUBLIC_SUBNET=subnet-xxxxxx`

### Tag the Public Subnet
- `aws ec2 create-tags --resources $VPC_PUBLIC_SUBNET --tags Key=Name,Value=rsm-prd-public-SN`
