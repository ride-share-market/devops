# AWS VPC Public Subnet Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create public subnet (an associated route table will be created automatically)
- `aws ec2 create-subnet --vpc-id $VPCID --cidr-block 10.0.0.0/24`

- From the command output, save/export the **SubnetId** to en environment variable
- `export VPCPUBLICSUBNET=subnet-xxxxxx`

### Create and internet gateway

- `aws ec2 create-internet-gateway`

- From the command output, save/export the **InternetGatewayId** to en environment variable
- `export VPCIGW=igw-xxxxxx`

### Attach the internet gateway to the VPC

- `aws ec2 attach-internet-gateway --internet-gateway-id $VPCIGW --vpc-id $VPCID`

### Create a route table for the public subnet 

- `aws ec2 create-route-table --vpc-id $VPCID`

- From the command output, save/export the **RouteTableId** to en environment variable
- `export VPCPUBLICROUTETABLE=rtb-xxxxxx`

### Create a route from the public subnet to the internet

- `aws ec2 create-route --route-table-id $VPCPUBLICROUTETABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $VPCIGW`

### Associate the public route table to the public subnet

- `aws ec2 associate-route-table --subnet-id $VPCPUBLICSUBNET --route-table-id $VPCPUBLICROUTETABLE`
