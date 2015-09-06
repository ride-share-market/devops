## AWS Server Instance

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Create and EC2 Key Pair if required, else ssh-add the existing one.
- `ssh-add ~/.ssh/amazon-vpc-singapore.pem`
- Create a Ubuntu 14.04.2 LTS server instance.
- The cloud-init config will apt-get update, upgrade, install ntp and then reboot.
- `aws ec2 run-instances --image-id ami-96f1c1c4 --instance-type t2.micro --subnet-id subnet-b372eed6 --security-group-ids sg-02b1c467 --key-name amazon-vpc-singapore --user-data file://./user-data`

```
{
    "OwnerId": "205565617391", 
    "ReservationId": "r-a70a026a", 
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
            "LaunchTime": "2015-09-06T08:58:51.000Z", 
            "PrivateIpAddress": "10.0.0.30", 
            "ProductCodes": [], 
            "VpcId": "vpc-ba7ed2df", 
            "StateTransitionReason": "", 
            "InstanceId": "i-37b06693", 
            "ImageId": "ami-96f1c1c4", 
            "PrivateDnsName": "ip-10-0-0-30.ap-southeast-1.compute.internal", 
            "KeyName": "amazon-vpc-singapore", 
            "SecurityGroups": [
                {
                    "GroupName": "SSHSecurityGroup", 
                    "GroupId": "sg-02b1c467"
                }
            ], 
            "ClientToken": "", 
            "SubnetId": "subnet-b372eed6", 
            "InstanceType": "t2.micro", 
            "NetworkInterfaces": [
                {
                    "Status": "in-use", 
                    "MacAddress": "02:78:68:2a:53:fb", 
                    "SourceDestCheck": true, 
                    "VpcId": "vpc-ba7ed2df", 
                    "Description": "", 
                    "NetworkInterfaceId": "eni-06681562", 
                    "PrivateIpAddresses": [
                        {
                            "PrivateDnsName": "ip-10-0-0-30.ap-southeast-1.compute.internal", 
                            "Primary": true, 
                            "PrivateIpAddress": "10.0.0.30"
                        }
                    ], 
                    "PrivateDnsName": "ip-10-0-0-30.ap-southeast-1.compute.internal", 
                    "Attachment": {
                        "Status": "attaching", 
                        "DeviceIndex": 0, 
                        "DeleteOnTermination": true, 
                        "AttachmentId": "eni-attach-06ce942f", 
                        "AttachTime": "2015-09-06T08:58:51.000Z"
                    }, 
                    "Groups": [
                        {
                            "GroupName": "SSHSecurityGroup", 
                            "GroupId": "sg-02b1c467"
                        }
                    ], 
                    "SubnetId": "subnet-b372eed6", 
                    "OwnerId": "205565617391", 
                    "PrivateIpAddress": "10.0.0.30"
                }
            ], 
            "SourceDestCheck": true, 
            "Placement": {
                "Tenancy": "default", 
                "GroupName": "", 
                "AvailabilityZone": "ap-southeast-1a"
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