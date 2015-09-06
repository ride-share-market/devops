## AWS IP and DNS

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- Allocate an IP address
- `aws ec2 allocate-address --domain vpc`

```
{
    "PublicIp": "52.76.79.143", 
    "Domain": "vpc", 
    "AllocationId": "eipalloc-c68e4aa3"
}
```

- Associate IP to instance
- `aws ec2 associate-address --instance-id i-37b06693 --allocation-id eipalloc-c68e4aa3`

```
{
    "AssociationId": "eipassoc-24067741"
}
```

- DNS upsert A record.
- Update the [upsert template](./dns-upsert-a-record.json) with the IP address created above.
- `aws route53 change-resource-record-sets --hosted-zone-id Z2Y8J8HP9H88E5 --change-batch file://../../docs/aws/dns-upsert-a-record.json`

```
{
    "ChangeInfo": {
        "Status": "PENDING", 
        "Comment": "Add DNS A record", 
        "SubmittedAt": "2015-09-06T09:09:36.636Z", 
        "Id": "/change/C2LVYZGNGOE0SM"
    }
}
```
