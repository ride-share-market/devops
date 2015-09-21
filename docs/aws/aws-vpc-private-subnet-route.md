### Create a route for the private network to the internet via the NAT instance

- `aws ec2 create-route --route-table-id $VPC_PRIVATE_ROUTE_TABLE --destination-cidr-block 0.0.0.0/0 --instance-id $VPC_BASTION_INSTANCE`
