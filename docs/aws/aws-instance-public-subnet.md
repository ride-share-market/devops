## AWS Public Server Instance

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Create and EC2 Key Pair if required, else ssh-add the existing one.
- `export VPC_EC2_KEY_PAIR=amazon-rsm-01`
- `ssh-add ~/.ssh/${VPC_EC2_KEY_PAIR}.pem`
- Create a Ubuntu 14.04.2 LTS server instance.
- The cloud-init config will apt-get update, upgrade, install ntp and then reboot.
- `aws ec2 run-instances --image-id $VPC_AMI_ID --instance-type t2.micro --subnet-id $VPC_PUBLIC_SUBNET --security-group-ids $VPC_DEFAULT_SECURITY_GROUP $VPC_BASTION_SECURITY_GROUP $VPC_WWW_SECURITY_GROUP $VPC_ICMP_SECURITY_GROUP --key-name $VPC_EC2_KEY_PAIR --user-data file://./aws/user-data`

- From the command output, save/export the **InstanceId** to en environment variable
- `export VPC_BASTION_INSTANCE=i-xxxxxx`

### Tag the Instance
- `aws ec2 create-tags --resources $VPC_BASTION_INSTANCE --tags Key=Name,Value=rsm-prd-bastion-I`

- Enable the instance to NAT
- `aws ec2 modify-instance-attribute --instance-id $VPC_BASTION_INSTANCE --attribute sourceDestCheck --value false`
