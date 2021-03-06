## AWS IP and DNS

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Allocate an IP address
- `aws ec2 allocate-address --domain vpc`

- From the command output, save/export the **PublicIP** to en environment variable
- `export VPC_PUBLIC_IP=xxx.xxx.xxx.xxx`
- From the command output, save/export the **AllocationId** to en environment variable
- `export VPC_PUBLIC_IP_ALLOCATION_ID=eipalloc-xxxxxx`

- Associate IP to instance
- `aws ec2 associate-address --instance-id $VPC_BASTION_INSTANCE --allocation-id $VPC_PUBLIC_IP_ALLOCATION_ID`

- DNS upsert A record.
- Update the [upsert template](./dns-upsert-a-record.json) with the IP address created above.
- `aws route53 change-resource-record-sets --hosted-zone-id xxxxxx --change-batch file://../../docs/aws/dns-upsert-a-record.json`
