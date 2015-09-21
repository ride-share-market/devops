# AWS VPC Public Route Table Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create a route table for the public subnet 

- `aws ec2 create-route-table --vpc-id $VPC_ID`

- From the command output, save/export the **RouteTableId** to en environment variable
- `export VPC_PUBLIC_ROUTE_TABLE=rtb-xxxxxx`

### Tag the Public Route Table
- `aws ec2 create-tags --resources $VPC_PUBLIC_ROUTE_TABLE --tags Key=Name,Value=rsm-prd-public-RT`

### Create a route from the public subnet to the internet

- `aws ec2 create-route --route-table-id $VPC_PUBLIC_ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $VPC_IGW`

### Associate the public route table to the public subnet

- `aws ec2 associate-route-table --subnet-id $VPC_PUBLIC_SUBNET --route-table-id $VPC_PUBLIC_ROUTE_TABLE`
