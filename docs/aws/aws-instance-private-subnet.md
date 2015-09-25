## AWS Server Instance

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Create a Ubuntu 14.04.2 LTS server instance.
- The cloud-init config will apt-get update, upgrade, install ntp and then reboot.
- `aws ec2 run-instances --image-id $VPC_AMI_ID --instance-type t2.medium --subnet-id $VPC_PRIVATE_SUBNET --security-group-ids $VPC_DEFAULT_SECURITY_GROUP --key-name $VPC_EC2_KEY_PAIR --block-device-mappings file://./aws/block_device_mapping_db.json --user-data file://./aws/user-data`

- From the command output, save/export the **InstanceId** to en environment variable
- `export VPC_DB_INSTANCE=i-xxxxxx`

### Tag the Instance
- `aws ec2 create-tags --resources $VPC_DB_INSTANCE --tags Key=Name,Value=rsm-prd-db-I`
