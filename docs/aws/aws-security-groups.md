## AWS Security Groups

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

### Create Security Groups

NATSG Security group

- `aws ec2 create-security-group --group-name NATSG --description "External Access Group" --vpc-id $VPCID`

- From the command output, save/export the **GroupId** to en environment variable
- `export VPCNATSG=sg-xxxxxx`

DBServerSG Security group

- `aws ec2 create-security-group --group-name DBServerSG --description "Internal Database Servers Group" --vpc-id $VPCID`

- From the command output, save/export the GroupId to en environment variable
- `export VPCDBSERVERSG=sg-xxxxxx`

### Create Security Group Ingress Rules

NATSG Security group ingress rules

- Accept traffic from machines in it's own group
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol tcp --port 0-65535 --source-group $VPCNATSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol udp --port 0-65535 --source-group $VPCNATSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol icmp --port -1 --source-group $VPCNATSG`
- Accept traffic from machines in DBServerSG
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol tcp --port 0-65535 --source-group $VPCDBSERVERSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol udp --port 0-65535 --source-group $VPCDBSERVERSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol icmp --port -1 --source-group $VPCDBSERVERSG`
- Accept SSH traffic
- `aws ec2 authorize-security-group-ingress --group-id $VPCNATSG --protocol tcp --port 22 --cidr 0.0.0.0/0`

DBServerSG Security group ingress rules

- Accept traffic from machines in it's own group
- `aws ec2 authorize-security-group-ingress --group-id $VPCDBSERVERSG --protocol tcp --port 0-65535 --source-group $VPCDBSERVERSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCDBSERVERSG --protocol udp --port 0-65535 --source-group $VPCDBSERVERSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCDBSERVERSG --protocol icmp --port -1 --source-group $VPCDBSERVERSG`
- Accept traffic from machines in NATSG
- `aws ec2 authorize-security-group-ingress --group-id $VPCDBSERVERSG --protocol tcp --port 0-65535 --source-group $VPCNATSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCDBSERVERSG --protocol udp --port 0-65535 --source-group $VPCNATSG`
- `aws ec2 authorize-security-group-ingress --group-id $VPCDBSERVERSG --protocol icmp --port -1 --source-group $VPCNATSG`
