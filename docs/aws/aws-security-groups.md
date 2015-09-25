## AWS Security Groups

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create Security Groups

**Bastion Security Group** - Developer remote access (SSH and VPN)

- `aws ec2 create-security-group --group-name BastionSG --description "Bastion security group" --vpc-id $VPC_ID`

- From the command output, save/export the **GroupId** to en environment variable
- `export VPC_BASTION_SECURITY_GROUP=sg-xxxxxx`

### Tag the Bastion Security Group
- `aws ec2 create-tags --resources $VPC_BASTION_SECURITY_GROUP --tags Key=Name,Value=rsm-prd-bastion-SG`

### Create Bastion Security Group Ingress Rules

- Accept SSH traffic
- `aws ec2 authorize-security-group-ingress --group-id $VPC_BASTION_SECURITY_GROUP --protocol tcp --port 22 --cidr 0.0.0.0/0`
- Accept OpenVPN traffic
- `aws ec2 authorize-security-group-ingress --group-id $VPC_BASTION_SECURITY_GROUP --protocol udp --port 1194 --cidr 0.0.0.0/0`

**HTTP/S Security Group** - Public web server access

- `aws ec2 create-security-group --group-name WWWSG --description "WWW security group" --vpc-id $VPC_ID`

- From the command output, save/export the **GroupId** to en environment variable
- `export VPC_WWW_SECURITY_GROUP=sg-xxxxxx`

### Tag the WWW Security Group
- `aws ec2 create-tags --resources $VPC_WWW_SECURITY_GROUP --tags Key=Name,Value=rsm-prd-www-SG`

### Create WWW Security Group Ingress Rules

- Accept HTTP traffic
- `aws ec2 authorize-security-group-ingress --group-id $VPC_WWW_SECURITY_GROUP --protocol tcp --port 80 --cidr 0.0.0.0/0`
- Accept HTTPS traffic
- `aws ec2 authorize-security-group-ingress --group-id $VPC_WWW_SECURITY_GROUP --protocol tcp --port 443 --cidr 0.0.0.0/0`




**ICMP Security Group** - Public servers

- `aws ec2 create-security-group --group-name ICMPSG --description "ICMP security group" --vpc-id $VPC_ID`

- From the command output, save/export the **GroupId** to en environment variable
- `export VPC_ICMP_SECURITY_GROUP=sg-xxxxxx`

### Tag the ICMP Security Group
- `aws ec2 create-tags --resources $VPC_ICMP_SECURITY_GROUP --tags Key=Name,Value=rsm-prd-icmp-SG`

### Create ICMP Security Group Ingress Rules

**Todo**: Restrict ICMP types

- Accept all ICMP traffic
- `aws ec2 authorize-security-group-ingress --group-id $VPC_ICMP_SECURITY_GROUP --protocol icmp --port -1 --cidr 0.0.0.0/0`
