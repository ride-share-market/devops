package main

import (
    "strings"
)

func main() {
    options := []string{
        "knife ec2 server create",
        "--image ami-df6a8b9b",
        "--flavor t2.micro",
        "--associate-public-ip",
        "--region us-west-1",
        "--availability-zone us-west-1c",
        "--subnet subnet-f4fa7191",
        "--security-group-ids sg-3892f95d",
        "--ssh-user ubuntu",
        "--ssh-key amazon-rsm-02",
        "--identity-file ~/.ssh/amazon-rsm-02.pem",
        }

    println(strings.Join(options, " "))

}

// ec2-create-vpc --region us-west-1 10.0.0.0/16
VPC     vpc-f3b51996    pending 10.0.0.0/16     dopt-fd07eb98   default

// ec2-create-subnet --region us-west-1 -c vpc-f3b51996 -i 10.0.0.0/24
SUBNET  subnet-4c58d329 pending vpc-f3b51996    10.0.0.0/24     251     us-west-1c

// ec2-create-route-table --region us-west-1 vpc-f3b51996
ROUTETABLE      rtb-a02595c5    vpc-f3b51996
ROUTE   local           active  10.0.0.0/16                     CreateRouteTable

// ec2-associate-route-table --region us-west-1 rtb-a02595c5 -s subnet-4c58d329
ASSOCIATION     rtbassoc-9cb00df9       rtb-a02595c5    subnet-4c58d329

// ec2-create-internet-gateway --region us-west-1
INTERNETGATEWAY igw-af3af5ca

// ec2-attach-internet-gateway --region us-west-1 igw-af3af5ca -c vpc-f3b51996
ATTACHMENT      vpc-f3b51996    attaching

// ec2-create-route --region us-west-1 rtb-a02595c5 -r 0.0.0.0/0 -g igw-af3af5ca
ROUTE   igw-af3af5ca                    0.0.0.0/0

// ec2-allocate-address --region us-west-1 -d vpc
ADDRESS 54.153.54.202           vpc     eipalloc-438c7926

# Use the default security group created for this VPC
// knife ec2 server create --image ami-df6a8b9b --flavor t2.micro --region us-west-1 --availability-zone us-west-1c --subnet subnet-4c58d329 --ssh-user ubuntu --security-group-ids sg-3e563c5b --ssh-key amazon-rsm-02 --identity-file ~/.ssh/amazon-rsm-02.pem

// ec2-associate-address --region us-west-1 -a eipalloc-438c7926 -i i-75d345b5
ADDRESS         i-75d345b5      eipalloc-438c7926       eipassoc-36ffb553

# Add SSH access to the default security group created for this VPC
ssh -v ubuntu@54.153.54.202

# Spin up another box
// knife ec2 server create --image ami-df6a8b9b --flavor t2.micro --region us-west-1 --availability-zone us-west-1c --subnet subnet-4c58d329 --ssh-user ubuntu --security-group-ids sg-3e563c5b --ssh-key amazon-rsm-02 --identity-file ~/.ssh/amazon-rsm-02.pem

# move the IP from 1st box to 2nd box
ec2-disassociate-address --region us-west-1 -a eipassoc-36ffb553
ec2-associate-address --region us-west-1 -a eipalloc-438c7926 -i i-66d147a6

# Flip IP back to 1st box
ec2-disassociate-address --region us-west-1 -a eipassoc-19fcb67c
ec2-associate-address --region us-west-1 -a eipalloc-438c7926 -i i-75d345b5

knife ec2 server delete --region us-west-1 i-66d147a6
knife ec2 server delete --region us-west-1 i-75d345b5

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
iptables --append FORWARD --in-interface eth0 -j ACCEPT
iptables -vnL
iptables -vnL -t nat
