# Application Deployment


## VBX

Once all the repos are setup with their configs, copy those private configs to the CI server.

- `cd ride-share-market/devops/app`
- `bundle exec cap vbx upload_app_config` 

Build each repo on the CI server.

- `zsh` shell
- `export CI_TOKEN=GET-TOKEN-FROM-KEEPASS-SECRETS`
- Build docker containers and the first node app. The first node app will download iojs.
- `for JOB (iojs nginx logstash-forwarder data) { curl "http://192.168.33.10:8081/job/$JOB/build?token=$CI_TOKEN" }`
- Next two node apps (will use the downloaded iojs from the previous build run)
- `for JOB (api app) { curl "http://192.168.33.10:8081/job/$JOB/build?token=$CI_TOKEN" }`

Create Docker Images and push to vbx private repo.

Build each image one by one depending one the current passing CI build version.

- `export PATH=/opt/chef/embedded/bin:$PATH`
- `ruby docker-build.rb --name rsm-nginx --version x.x.x --jenkinsjob nginx`
- `ruby docker-build.rb --name rsm-logstash-forwarder --version x.x.x -j logstash-forwarder`
- `ruby docker-build.rb --name rsm-iojs --version x.x.x -j iojs`
- `ruby docker-build.rb --name rsm-data --version x.x.x -j data`
- `ruby docker-build.rb --name rsm-api --version x.x.x -j api`
- `ruby docker-build.rb --name rsm-app --version x.x.x -j app`

Deploy from Private docker registry to vbx

- `ruby docker-deploy.rb --env vbx`

## Local

The application is build with several Docker containers that work together.

- rsm-data
- rsm-api
- rsm-app
- [rsm-nginx](../app/docker/nginx/README.md)
- [rsm-logstash-forwarder](../app/docker/logstash-forwarder/README.md)

### Step 1

Build locally and push the application docker images to the local private registry.

### Step 2

### Local Developer Machine

The docker images and container names to be used for deployment are stored in a JSON file.

Update [rsm.json](../app/kitchen/data_bags/docker/rsm.json) to the required versions.

On the Remote server:
 
1. Pull down the images from the local docker registry.
2. Remove any running containers in order.
3. Start containers in order.

These steps are handled using Capistrano

- `cd app`
- Virtual Machine (local)
- `bundle exec cap vbx docker_deploy`
