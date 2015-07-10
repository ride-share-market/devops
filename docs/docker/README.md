## Install

[Developer Workstation](install_developer_workstation.md)

[Docker Private Registry](registry/README.md)

## Dockerui

- `sudo docker pull dockerui/dockerui`
- `sudo docker run -d --restart always --name rsm-docker-ui -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`
- [http://vbox.ridesharemarket.com:9000](http://vbox.ridesharemarket.com:9000)

## Usage

### Kernel Upgrade

Issue: All images and containers disappeared after host kernel upgrade

Solution: Inside the VM install the aufs kernel module that docker requires but can be lost during kernel upgrades. 

Not sure why the package manager misses this dependency.

- `sudo apt-get -y install linux-image-extra-$(uname -r)`
- `sudo init 6`

### Private Docker Registry

To list all images in the private registry:

- `curl -s 192.168.33.10:5000/v1/search`
- `curl -s 192.168.33.10:5000/v1/search | ~/bin/jq .`

To list all tags for a given image in the private registry:

- `curl -s 192.168.33.10:5000/v1/repositories/YOUR_IMAGE/tags`
- `curl -s 192.168.33.10:5000/v1/repositories/ride-share-market/rsm-nginx/tags`
- `curl -s 192.168.33.10:5000/v1/repositories/ride-share-market/rsm-nginx/tags | ~/bin/jq .`

To delete an image from the private registry.

- `curl -X DELETE 192.168.33.10:5000/v1/repositories/ride-share-market/rsm-nginx/tags/x.x.x`

curl -X DELETE lan.reg01.prd.ams.ridesharemarket.com:5000/v1/repositories/ride-share-market/rsm-app/tags/1.3.2
sudo docker rm -f -v rsm-app
sudo docker rmi -f ride-share-market/rsm-app:1.3.2
sudo docker rmi -f lan.reg01.prd.ams.ridesharemarket.com:5000/ride-share-market/rsm-app:1.3.2

curl -X DELETE lan.reg01.prd.ams.ridesharemarket.com:5000/v1/repositories/ride-share-market/rsm-api/tags/1.2.1
sudo docker rm -f -v rsm-api
sudo docker rmi -f ride-share-market/rsm-api:1.2.1
sudo docker rmi -f lan.reg01.prd.ams.ridesharemarket.com:5000/ride-share-market/rsm-api:1.2.1

curl -X DELETE lan.reg01.prd.ams.ridesharemarket.com:5000/v1/repositories/ride-share-market/rsm-data/tags/1.2.4
sudo docker rm -f -v rsm-data
sudo docker rmi -f ride-share-market/rsm-data:1.2.4
sudo docker rmi -f lan.reg01.prd.ams.ridesharemarket.com:5000/ride-share-market/rsm-data:1.2.4


To bulk delete images from the private registry.

- `for n ({1..5}) { curl -X DELETE 192.168.33.10:5000/v1/repositories/ride-share-market/rsm-nginx/tags/0.0.$n }`

### Local

Fire up a quick container that will remove itself up on close.

- `sudo docker run -i -t --rm ubuntu:14.04 /bin/bash`

To bulk delete images.

- `for n ({1..5}) { sudo docker rmi -f ride-share-market/rsm-nginx:0.0.$n }`


