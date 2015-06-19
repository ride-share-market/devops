# Local Developer Virtual Machine

## Install

- Start by clearing out any previous virtualbox known_hosts
- `ssh-keygen -f ~/.ssh/known_hosts -R vbox.ridesharemarket.com`
- `ssh-keygen -f ~/.ssh/known_hosts -R 192.168.33.10`
- Create the working directory and git clone
- `mkdir ride-share-market && cd ride-share-market`
- `git clone git@github.com:ride-share-market/devops.git`
- `cd devops && git checkout develop`
- Update developer workstation */etc/hosts*
- `app/lib/network_hosts.rb | sudo tee -a /etc/hosts && sudo vi /etc/hosts`
- Create a new Virtualbox instance with Vagrant
- `cd app`
- `vagrant plugin install vagrant-vbguest`
- `vagrant up`
- Configure the new Ubuntu VM
- `cd kitchen`
- `./devops.rb sshcopyid`
- `./devops.rb update_ubuntu_account`
- `./devops.rb upgrade`
- `./devops.rb reboot`
- `./devops.rb bootstrap`
- `berks vendor`
- `./devops.rb cook`

## Web Admin

- [Kibana](http://192.168.33.10:5601)
- [RabbitMQ](http://192.168.33.10:15672)
- [Graphite](http://192.168.33.10:8080)
- [Jenkins CI](http://192.168.33.10:8081)
- [Docker Private Registry](http://192.168.33.10:9001)

## Jenkins CI

The chef run will setup the application jobs, but you'll need to enter Jenkins admin
and do some manual configuration updates (for now).

### Plugins and Jobs

- Update all the installed plugins
- Configure Jenkins to use Ant v1.9.5
- Rerun chef on the CI node so it will update the Jenkins jobs that need the previous updates. 

### Authentication

The chef run will setup the jobs and user accounts but Auth needs to be turned on manually.

From the web UI enable these three options: 

- Jenkins > Manage Jenkins > Configure Global Security > Enable security
- Access Control > Security Realm > Jenkins' own user database 
- Access Control > Authorization > Logged-in users can do anything Security Realm 

## Docker

[Docker Install](../docs/docker/README.md)

## Deployment

[Deployment](deployment.md)
