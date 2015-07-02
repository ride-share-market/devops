## Requirements

- The devops digitalocean.com scripts need the environment variable RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN set.
- Check:
- `echo $RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN`
- Set (token from encrypted keepass file):
- `export RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN=abc123`

### Chef Server Data Bags
- `cd app/kitchen`
- `knife data bag create network`
- `knife data bag from file network data_bags/network/prd_ams_ridesharemarket.json`
- `knife data bag create network`
- `knife data bag from file secrets data_bags/secrets/secrets.json`
- `knife data bag create users`
- `knife data bag from file secrets data_bags/users/rsm-data.json`

### Chef Server Cookbooks
- `knife cookbook upload --all`
 
## Digital Ocean Server Instance

- Provision the server.
- `./devops.rb server_create redline`
- Update [kitchen/data_bags/network/prd_ams_ridesharemarket.json](../app/kitchen/data_bags/network/prd_ams_ridesharemarket.json) json file with the Digital Ocean Instance ID.
- Update [kitchen/data_bags/network/prd_ams_ridesharemarket.json](../app/kitchen/data_bags/network/prd_ams_ridesharemarket.json) json file with the Digital Ocean public IP address.
- Update developer workstation */etc/hosts*
- `../lib/network_hosts.rb | sudo tee -a /etc/hosts && sudo vi /etc/hosts`
- Get the LAN IP address from the new server
- `ssh -v root@redline ifconfig eth1 | grep 'inet\ addr'`
- Update data_bags/network json file with the Digital Ocean private LAN IP address.
- Update DNS (see below).
- Create Ubuntu user account (for all future devops operations)
- `./devops.rb create_ubuntu_account --user root --hostname redline`
- Upgrade the server.
- `./devops.rb upgrade --user ubuntu --hostname redline`
- Reboot the server (sanity check plus reboot into any new linux kernel).
- `./devops.rb reboot --user ubuntu --hostname redline`
- Bootstrap the server, which includes:
- apt-get autoremove.
- Copy in the chef secret key.
- Bootstrap the node with Chef and register with Chef Server 
- `./devops.rb server_bootstrap redline`
- Reboot the server and confirm boot up email received.
- `./devops.rb reboot --user ubuntu --hostname redline`

## Configure Chef Server run list

- [Chef Server Run List](chef_server.md)

## Configure Jenkins CI

- [Jenkins CI](jenkins-ci.md)

## Application Build and Deploy

- [Deployment](deployment.md)

## Destroy

- Destroy Digital Ocean instance.
- Delete Chef Node.
- Delete Chef Client.
- Remove .ssh/known_hosts entries.
- `./devops.rb server_delete redline`

## DNS (Currently not in use)

- Create
- `knife digital_ocean domain create --name ridesharemarket.com -ip-address xxx.xxx.xxx.xxx`
- `knife digital_ocean domain record create --domain-id ridesharemarket.com --type CNAME --name www --data @`
- `knife digital_ocean domain record create --domain-id ridesharemarket.com --type A --name redline --data xxx.xxx.xxx.xxx`
- Update (remove then add)
- `knife digital_ocean domain record list -D ridesharemarket.com`
- Find the ID of the record to remove
- `knife digital_ocean domain record destroy --domain-id ridesharemarket.com --record-id xxxxxx`
- `knife digital_ocean domain record create --domain-id ridesharemarket.com --type A --name redline --data xxx.xxx.xxx.xxx`
