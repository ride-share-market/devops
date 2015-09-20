# OpenVPN

Configure local openvpn client to connect to VPC openvpn server.

From the keepass file copy the openvpn config files (chown to root) to `/etc/openvpn`

1. -rw-r--r--  root root ca.crt
2. -rw-r--r--  root root client.conf
3. -rw-r--r--  root root rsm-client1.crt
4. -rw-------  root root rsm-client1.key

Update /etc/openvpn/client.conf

- Update the IP to current VPS IP:
- `remote xxx.xxx.xxx.xxx 1194`
- Uncomment:
- `user nobody`
- `group nogroup`

Problem: I can ping through the tunnel but any real work causes it to lock up.

Solution: When using UDP (preferred) alter the MTU size.

**Client** - Update `/etc/default/openvpn`

`OPTARGS="--fragment 1400 --mssfix"`

**Server**: Chef recipe will configure remote server /etc/default/openvpn

`OPTARGS="--fragment 1400"`

**Note**: Client and Server must have matching --fragment values

References:

- [Community Blog Post](https://community.openvpn.net/openvpn/wiki/271-i-can-ping-through-the-tunnel-but-any-real-work-causes-it-to-lock-up-is-this-an-mtu-problem)
- [Docs](https://openvpn.net/index.php/open-source/documentation/manuals/65-openvpn-20x-manpage.html)
- [Blog Post](http://michael.stapelberg.de/Artikel/mtu_openvpn/)
