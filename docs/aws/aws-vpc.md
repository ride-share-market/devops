# AWS VPC Setup

[AWS CLI Documentation](http://docs.aws.amazon.com/cli/latest/index.html)

- **Step 1: Create a new Virtual Private Cloud**
- `aws ec2 create-vpc --cidr-block 10.0.0.0/16`

```
{
    "Vpc": {
        "InstanceTenancy": "default", 
        "State": "pending", 
        "VpcId": "vpc-ecf35189", 
        "CidrBlock": "10.0.0.0/16", 
        "DhcpOptionsId": "dopt-f2cc3b97"
    }
}
```

- **Step 2: Modify VPC attributes (instance with public IP will get an amazon dns record)**
- `aws ec2 modify-vpc-attribute --vpc-id vpc-ecf35189 --enable-dns-hostnames '{"Value":true}'`

- **Step 3: Create public subnet (an associate route table will be created)**
- `aws ec2 create-subnet --vpc-id vpc-ecf35189 --cidr-block 10.0.0.0/24`

```
{
    "Subnet": {
        "VpcId": "vpc-ecf35189", 
        "CidrBlock": "10.0.0.0/24", 
        "State": "pending", 
        "AvailabilityZone": "ap-southeast-1b", 
        "SubnetId": "subnet-01f34876", 
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
        "InternetGatewayId": "igw-de9c49bb", 
        "Attachments": []
    }
}
```

- **Step 5**
- `aws ec2 attach-internet-gateway --internet-gateway-id igw-de9c49bb --vpc-id vpc-ecf35189`

- **Step 6: Create a route from the public subnet to the internet**
- `aws ec2 create-route --route-table-id rtb-1840c47d --destination-cidr-block 0.0.0.0/0 --gateway-id igw-de9c49bb`

```
{
    "Return": true
}
```

- **Step 7: Create a new security group**
- `aws ec2 create-security-group --group-name SSHSecurityGroup --description "External Access Group" --vpc-id vpc-ecf35189`

```
{
    "GroupId": "sg-266f0743"
}
```

- **Step 8: Security group ingress rules**
- `aws ec2 authorize-security-group-ingress --group-id sg-266f0743 --protocol tcp --port 22 --cidr 0.0.0.0/0`

- **Step 9: Start a single instance**
- `aws ec2 run-instances --image-id ami-96f1c1c4 --instance-type t2.micro --subnet-id subnet-01f34876 --security-group-ids sg-266f0743 --key-name amazon-vpc-singapore --user-data file://./user-data`

```
{
    "OwnerId": "205565617391", 
    "ReservationId": "r-230e2cef", 
    "Groups": [], 
    "Instances": [
        {
            "Monitoring": {
                "State": "disabled"
            }, 
            "PublicDnsName": "", 
            "RootDeviceType": "ebs", 
            "State": {
                "Code": 0, 
                "Name": "pending"
            }, 
            "EbsOptimized": false, 
            "LaunchTime": "2015-08-31T08:57:52.000Z", 
            "PrivateIpAddress": "10.0.0.38", 
            "ProductCodes": [], 
            "VpcId": "vpc-ecf35189", 
            "StateTransitionReason": "", 
            "InstanceId": "i-8f8a6640", 
            "ImageId": "ami-96f1c1c4", 
            "PrivateDnsName": "ip-10-0-0-38.ap-southeast-1.compute.internal", 
            "KeyName": "amazon-vpc-singapore", 
            "SecurityGroups": [
                {
                    "GroupName": "SSHSecurityGroup", 
                    "GroupId": "sg-266f0743"
                }
            ], 
            "ClientToken": "", 
            "SubnetId": "subnet-01f34876", 
            "InstanceType": "t2.micro", 
            "NetworkInterfaces": [
                {
                    "Status": "in-use", 
                    "MacAddress": "06:b8:6f:3f:a4:77", 
                    "SourceDestCheck": true, 
                    "VpcId": "vpc-ecf35189", 
                    "Description": "", 
                    "NetworkInterfaceId": "eni-3949c44f", 
                    "PrivateIpAddresses": [
                        {
                            "PrivateDnsName": "ip-10-0-0-38.ap-southeast-1.compute.internal", 
                            "Primary": true, 
                            "PrivateIpAddress": "10.0.0.38"
                        }
                    ], 
                    "PrivateDnsName": "ip-10-0-0-38.ap-southeast-1.compute.internal", 
                    "Attachment": {
                        "Status": "attaching", 
                        "DeviceIndex": 0, 
                        "DeleteOnTermination": true, 
                        "AttachmentId": "eni-attach-550c3a7d", 
                        "AttachTime": "2015-08-31T08:57:52.000Z"
                    }, 
                    "Groups": [
                        {
                            "GroupName": "SSHSecurityGroup", 
                            "GroupId": "sg-266f0743"
                        }
                    ], 
                    "SubnetId": "subnet-01f34876", 
                    "OwnerId": "205565617391", 
                    "PrivateIpAddress": "10.0.0.38"
                }
            ], 
            "SourceDestCheck": true, 
            "Placement": {
                "Tenancy": "default", 
                "GroupName": "", 
                "AvailabilityZone": "ap-southeast-1b"
            }, 
            "Hypervisor": "xen", 
            "BlockDeviceMappings": [], 
            "Architecture": "x86_64", 
            "StateReason": {
                "Message": "pending", 
                "Code": "pending"
            }, 
            "RootDeviceName": "/dev/sda1", 
            "VirtualizationType": "hvm", 
            "AmiLaunchIndex": 0
        }
    ]
}
```

- **Step 10: Allocate an IP address**
- `aws ec2 allocate-address --domain vpc`

```
{
    "PublicIp": "52.76.22.138", 
    "Domain": "vpc", 
    "AllocationId": "eipalloc-de0ff5bb"
}
```

- **Step 11: Associate IP to instance**
- `aws ec2 associate-address --instance-id i-8f8a6640 --allocation-id eipalloc-de0ff5bb`

```
{
    "AssociationId": "eipassoc-f1750194"
}
```

- **Step 12: DNS create|upsert**
- `aws route53 change-resource-record-sets --hosted-zone-id Z2Y8J8HP9H88E5 --change-batch file://./add-a-record.json`

```
{
    "ChangeInfo": {
        "Status": "PENDING", 
        "Comment": "Add DNS A record", 
        "SubmittedAt": "2015-08-31T09:13:02.731Z", 
        "Id": "/change/CCXZGBPERODVR"
    }
}
```

- **Step 13: Login with SSH**
- `ssh -v ubuntu@52.76.22.138`
- `ssh -v ubuntu@ec2-52-76-22-138.ap-southeast-1.compute.amazonaws.com`
- `ssh -v ubuntu@ssh01.ridesharemarket.com`

- **Step 14: Login with SSH**

- TODO: scp secret_key
- `knife bootstrap ssh01.ridesharemarket.com --yes --sudo --node-name ssh01 --bootstrap-version 12.3.0 --ssh-user ubuntu --run-list 'recipe[hostname],recipe[chef-client],recipe[chef-client::delete_validation]' --json-attributes '{"set_fqdn":"ssh01.ridesharemarket.com"}'`
