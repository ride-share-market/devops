## Digital Ocean Server Instance

- Provision the server.
- `./devops.rb server_create redline`
- Update [kitchen/data_bags/network/prd_ams_ridesharemarket.json](../../../app/kitchen/data_bags/network/prd_ams_ridesharemarket.json) json file with the Digital Ocean Instance ID.
- Update [kitchen/data_bags/network/prd_ams_ridesharemarket.json](../../../app/kitchen/data_bags/network/prd_ams_ridesharemarket.json) json file with the Digital Ocean public IP address.
- Update developer workstation */etc/hosts*
- `../lib/network_hosts.rb | sudo tee -a /etc/hosts && sudo vi /etc/hosts`
- Get the LAN IP address from the new server
- `ssh -v root@redline ifconfig eth1 | grep 'inet\ addr'`
- Update [kitchen/data_bags/network/prd_ams_ridesharemarket.json](../../../app/kitchen/data_bags/network/prd_ams_ridesharemarket.json) json file with the Digital Ocean private LAN IP address.
- Upload updated network data_bag
- `knife data bag from file network data_bags/network/prd_ams_ridesharemarket.json`
- Update DNS (see below).
- Create Ubuntu user account (for all future devops operations)
- `./devops.rb create_ubuntu_account --user root --hostname redline`
- Upgrade the server.
- `./devops.rb upgrade --user ubuntu --hostname redline`
- Reboot the server (sanity check plus reboot into any new linux kernel).
- `./devops.rb reboot --user ubuntu --hostname redline`
- Bootstrap the server, which will:
    - apt-get autoremove.
    - Copy in the chef secret key.
    - Bootstrap the node with chef-client, register with Chef Server and do an initial chef-client run. 
- `./devops.rb server_bootstrap redline`
- Reboot the server and confirm boot up email received.
- `./devops.rb reboot --user ubuntu --hostname redline`

## Configure Chef Server run list

- Details and Overiew are here: [Chef Server Run List](../../../docs/chef_server.md)
- `knife node run_list add redline relk,metrics,mongodb,git-repos,docker-wrapper-prd,docker-containers-prd,jenkins-cookbook`
- Chef run (remote):
- `knife ssh -x ubuntu 'name:redline' 'sudo -u root -i chef-client'`
- Chef run (local):
- ssh into the server and run the chef-client
- `mosh ubuntu@redline`
- `sudo -u root -i chef-client`

  
## Configure Jenkins CI

- [redline.ridesharemarket.com:8081](http://redline.ridesharemarket.com:8081/)
- [Jenkins CI](../../../docs/jenkins-ci.md)

## Application Build and Deploy

- [Deployment](../../../docs/deployment.md)

## Destroy

- Destroy Digital Ocean instance.
- Delete Chef Node.
- Delete Chef Client.
- Remove .ssh/known_hosts entries.
- `./devops.rb server_delete redline`

## DNS (Currently not in use)

Update Godaddy.com

- A record
- CNAME: www
- CNAME: api
- CNAME: redline
- TODO: cdn -> cdn77

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
