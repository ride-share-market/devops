## AWS Server Instance

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Create and EC2 Key Pair if required, else ssh-add the existing one.
- `ssh-add ~/.ssh/amazon-vpc-singapore.pem`
- Create a Ubuntu 14.04.2 LTS server instance.
- The cloud-init config will apt-get update, upgrade, install ntp and then reboot.
- `aws ec2 run-instances --image-id ami-96f1c1c4 --instance-type t2.micro --subnet-id $VPCPUBLICSUBNET --security-group-ids $VPCNATSG --key-name amazon-vpc-singapore --user-data file://./user-data`

- From the command output, save/export the **InstanceId** to en environment variable
- `export VPCNATINSTANCE=i-7107f7be`

- Enable the instance to route
- `aws ec2 modify-instance-attribute --instance-id $VPCNATINSTANCE --attribute sourceDestCheck --value false`
