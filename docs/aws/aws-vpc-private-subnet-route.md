### Create a route for the private network to the internet via the NAT instance

- `aws ec2 create-route --route-table-id $VPCPRIVATEROUTETABLE --destination-cidr-block 0.0.0.0/0 --instance-id $VPCNATINSTANCE`
