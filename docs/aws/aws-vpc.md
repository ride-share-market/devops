# AWS VPC Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create a new Virtual Private Cloud
- `aws ec2 create-vpc --cidr-block 10.0.0.0/16`

- From the command output, save/export the **VpcId** to en environment variable
- `export VPCID=vpc-xxxxxx`

### Modify VPC attributes (instance with public IP will get an amazon dns record)
- `aws ec2 modify-vpc-attribute --vpc-id $VPCID --enable-dns-hostnames '{"Value":true}'`

### From the new VPC get the ID of the auto created **Main** route table

- `aws ec2 describe-route-tables | jq ".RouteTables[] | select(.VpcId == \"$VPCID\")" | jq '.RouteTableId'`

- From the command output, save/export the **RouteTableId** to en environment variable
- `export VPCPRIVATEROUTETABLE=rtb-xxxxxx`
