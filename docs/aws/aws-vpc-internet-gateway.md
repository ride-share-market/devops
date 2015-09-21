# AWS VPC Internet Gateway Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create and internet gateway

- `aws ec2 create-internet-gateway`

- From the command output, save/export the **InternetGatewayId** to en environment variable
- `export VPC_IGW=igw-xxxxxx`

### Attach the internet gateway to the VPC

- `aws ec2 attach-internet-gateway --internet-gateway-id $VPC_IGW --vpc-id $VPC_ID`

### Tag the Internet Gateway
- `aws ec2 create-tags --resources $VPC_IGW --tags Key=Name,Value=rsm-prd-IGW`
