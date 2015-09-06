# AWS VPC Setup

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- **Step 1: Create a new Virtual Private Cloud**
- `aws ec2 create-vpc --cidr-block 10.0.0.0/16`

```
{
    "Vpc": {
        "InstanceTenancy": "default", 
        "State": "pending", 
        "VpcId": "vpc-ba7ed2df", 
        "CidrBlock": "10.0.0.0/16", 
        "DhcpOptionsId": "dopt-f2cc3b97"
    }
}
```

- **Step 2: Modify VPC attributes (instance with public IP will get an amazon dns record)**
- `aws ec2 modify-vpc-attribute --vpc-id vpc-ba7ed2df --enable-dns-hostnames '{"Value":true}'`

- **Step 3: Create public subnet (an associate route table will be created)**
- `aws ec2 create-subnet --vpc-id vpc-ba7ed2df --cidr-block 10.0.0.0/24`

```
{
    "Subnet": {
        "VpcId": "vpc-ba7ed2df", 
        "CidrBlock": "10.0.0.0/24", 
        "State": "pending", 
        "AvailabilityZone": "ap-southeast-1a", 
        "SubnetId": "subnet-b372eed6", 
        "AvailableIpAddressCount": 251
    }
}
```

- **Step 4**
- `aws ec2 create-internet-gateway`

```
{
    "InternetGateway": {
        "Tags": [], 
        "InternetGatewayId": "igw-01d50164", 
        "Attachments": []
    }
}
```

- **Step 5**
- `aws ec2 attach-internet-gateway --internet-gateway-id igw-01d50164 --vpc-id vpc-ba7ed2df`

- **Step 6: Create a route from the public subnet to the internet**
- `aws ec2 create-route --route-table-id rtb-fc1d9b99 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-01d50164`

```
{
    "Return": true
}
```
