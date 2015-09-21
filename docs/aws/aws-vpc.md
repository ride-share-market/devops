# AWS VPC Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create a new Virtual Private Cloud
- `aws ec2 create-vpc --cidr-block 10.0.0.0/16`

- From the command output, save/export the **VpcId** to en environment variable
- `export VPC_ID=vpc-xxxxxx`

### Tag the VPC
- `aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value=rsm-prd`

### Modify VPC attributes (instance with public IP will get an amazon dns record)
- `aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames '{"Value":true}'`

### From the new VPC get the ID of the auto created **Main route table**

- `aws ec2 describe-route-tables | jq ".RouteTables[] | select(.VpcId == \"$VPC_ID\")" | jq '.RouteTableId'`

- From the command output, save/export the **RouteTableId** to en environment variable
- `export VPC_MAIN_ROUTETABLE=rtb-xxxxxx`

### Tag the Main Route Table
- `aws ec2 create-tags --resources $VPC_MAIN_ROUTETABLE --tags Key=Name,Value=rsm-prd-main-RT`

### From the new VPC get the ID of the auto created **default security group**

- `aws ec2 describe-security-groups | jq ".SecurityGroups[] | select(.VpcId == \"$VPC_ID\")" | jq '.GroupId'`
- `export VPC_DEFAULT_SECURITY_GROUP=sg-xxxxxx`

### Tag the Default Security Group
- `aws ec2 create-tags --resources $VPC_DEFAULT_SECURITY_GROUP --tags Key=Name,Value=rsm-prd-default-SG`
