## AWS Security Group

Step by step examples follow (includes samples of command output).

As you proceed update the various IDs used from the output of each command.

- `aws ec2 create-security-group --group-name SSHSecurityGroup --description "External Access Group" --vpc-id vpc-ba7ed2df`

```
{
    "GroupId": "sg-02b1c467"
}
```

- Security group ingress rules
- `aws ec2 authorize-security-group-ingress --group-id sg-02b1c467 --protocol tcp --port 22 --cidr 0.0.0.0/0`
