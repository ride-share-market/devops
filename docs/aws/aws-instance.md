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