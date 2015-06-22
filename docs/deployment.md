# Application Deployment

## Step 1

Once all the repos are setup with their configs, copy those private configs to the CI server.

- `cd ride-share-market/devops/app`
- `cap vbx app:upload_config`
 
## Step 2

Build each repo on the CI server.

- `zsh` shell
- `export CI_TOKEN=GET-TOKEN-FROM-KEEPASS-SECRETS`
- Build docker containers and the first node app. The first node app will download iojs.
- `for JOB (nginx iojs logstash-forwarder data api app) { curl "http://192.168.33.10:8081/job/$JOB/build?token=$CI_TOKEN" }`

## Step 3

Create Docker Images and push to the private docker registry.

Build each image one by one, use the current passing CI build version.

Note: No spaces in capistrano command arguments.

- `cap vbx docker:build[rsm-nginx,x.x.x,nginx]` 
- `cap vbx docker:build[rsm-logstash-forwarder,x.x.x,logstash-forwarder]` 
- `cap vbx docker:build[rsm-iojs,x.x.x,iojs]` 
- `cap vbx docker:build[rsm-data,x.x.x,data]` 
- `cap vbx docker:build[rsm-api,x.x.x,api]` 
- `cap vbx docker:build[rsm-app,x.x.x,app]` 

## Step 4

Deploy from Private docker registry, on the remote server(s):
 
1. Pull down the images from the private docker registry.
2. Remove any running containers in order.
3. Start containers in order.

- VBX environment
- `cap vbx docker:deploy`

### Step 2 Build Option

Docker images can also be built locally (from Ubuntu workstation non-VM).

Build locally and push the application docker images to the local docker private registry
using the docker-build.sh script from within each repo.

Then deploy with capistrano as detailed above.
