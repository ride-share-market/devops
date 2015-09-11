## AWS Server Instance

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Create a Ubuntu 14.04.2 LTS server instance.
- The cloud-init config will apt-get update, upgrade, install ntp and then reboot.
- `aws ec2 run-instances --image-id ami-96f1c1c4 --instance-type t2.micro --subnet-id $VPCPRIVATESUBNET --security-group-ids $VPCDBSERVERSG --key-name amazon-vpc-singapore --user-data file://./user-data`

- From the command output, save/export the **InstanceId** to en environment variable
- `export VPCPRIVATEINSTANCE=i-xxxxxx`
