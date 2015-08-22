# Local Developer Virtual Machine

- Chef Version
- Developer Host Machine: [Gemfile](../Gemfile)
- Developer VM Machine: [devops.rb](../app/kitchen/devops.rb)
- Production (remote) Machine(s): [prd_ams_ridesharemarket.json](../app/kitchen/data_bags/network/prd_ams_ridesharemarket.json)


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
- [Grafana](http://192.168.33.10:3000)
- [RabbitMQ](http://192.168.33.10:15672)
- [Couchbase](http://192.168.33.10:8091)
- [Jenkins CI](http://192.168.33.10:8081)
- [Docker Private Registry](http://192.168.33.10:9001)

## Configure Grafana

- [Grafana](grafana.md)

## Configure Jenkins CI

- [Jenkins CI](jenkins-ci.md)

## Deployment

Git clone all the application repos and then update the repo configurations.

These configurations are not kept in github, but are sync'd directly from the developer box to the CI server.

The configuration data is kept in a keepass file (encrypted) in the repo.

- `cd ride-share-market`
- `git clone git@github.com:ride-share-market/iojs.git`
- `git clone git@github.com:ride-share-market/nginx.git`
- `git clone git@github.com:ride-share-market/logstash-forwarder.git`
- `git clone git@github.com:ride-share-market/data.git`
- `git clone git@github.com:ride-share-market/api.git`
- `git clone git@github.com:ride-share-market/app.git`

Next consult each repo for it's setup details.

After each individual repo is setup locally continue to the [Deployment](deployment.md) docs.

## Docker

[Docker Install](../docs/docker/README.md)