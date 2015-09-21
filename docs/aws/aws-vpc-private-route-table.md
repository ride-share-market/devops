# AWS VPC Private Route Table Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create a route table for the private subnet 

- `aws ec2 create-route-table --vpc-id $VPC_ID`

- From the command output, save/export the **RouteTableId** to en environment variable
- `export VPC_PRIVATE_ROUTE_TABLE=rtb-xxxxxx`

### Tag the Private Route Table
- `aws ec2 create-tags --resources $VPC_PRIVATE_ROUTE_TABLE --tags Key=Name,Value=rsm-prd-private-RT`

### Associate the private route table to the private subnet

- `aws ec2 associate-route-table --subnet-id $VPC_PRIVATE_SUBNET --route-table-id $VPC_PRIVATE_ROUTE_TABLE`
