ubuntu@mandolin:~$ ssh -vvv -g -L 2222:10.0.1.50:22 ubuntu@10.0.1.50

ssh -vvv -g -L 5555:192.168.33.100:22 vagrant@192.168.33.101
> tcp        0      0 192.168.33.100:22       192.168.33.101:42014    ESTABLISHED 7732/sshd: vagrant 


ssh -vvv -g -R 5555:192.168.33.100:22 vagrant@192.168.33.101
> tcp        0      0 192.168.33.100:22       192.168.33.1:47551      ESTABLISHED 7877/sshd: vagrant 

ssh -vvv -g -R 2222:10.0.1.223:22 ubuntu@mandolin


ssh -A ubuntu@mandolin
ssh -vvv -g -L 2222:10.0.1.223:22 ubuntu@10.0.1.223


sudo iptables -t nat -A PREROUTING -p tcp --dport 2222 -j DNAT --to-destination 10.0.1.223:22
