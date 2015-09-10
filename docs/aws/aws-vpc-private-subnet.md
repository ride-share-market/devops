# AWS VPC Private Subnet Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create private subnet 

An associated route, the **main** route, table will be created automatically

- `aws ec2 create-subnet --vpc-id $VPCID --cidr-block 10.0.1.0/24`

- From the command output, save/export the **SubnetId** to en environment variable
- `export VPCPRIVATESUBNET=subnet-xxxxxx`
