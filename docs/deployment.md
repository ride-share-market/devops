# Application Deployment

## Step 1

Once all the repos are setup with their configs, copy those private configs to the CI server.

- `cd ride-share-market/devops/app`
- vbx environment
- `cap vbx docker:upload_config`
- prd environment
- `cap prd docker:upload_config`
 
## Step 2

Build repos on the CI server.

The **api** repo requires a running rsm-data container, as it has some database integration tests.

So we'll build that one last.

- `zsh` shell
- `export CI_TOKEN=GET-TOKEN-FROM-KEEPASS-SECRETS-JSON`
- Build repos, the first node app will download iojs.
- `for JOB (nginx iojs data app) { curl "http://192.168.33.100:8080/job/$JOB/build?token=$CI_TOKEN" }`

## Step 3

Create Docker Images and push to the private docker registry.

Build each image one by one, use the current passing CI build version.

Note: **No spaces** in capistrano command arguments.

- `cap vbx docker:build[rsm,iojs,x.x.x]`
- `cap vbx docker:build[rsm,nginx,x.x.x]` 
- `cap vbx docker:build[rsm,data,x.x.x]`
- `cap vbx docker:build[rsm,app,x.x.x]` 

## Step 4

- Manually start an rsm-data container for env vbx:
- `sudo docker run -d --restart always --name rsm-data --env 'NODE_ENV=vbx' --add-host lan.rmq01.prd.ams.ridesharemarket.com:192.168.33.100 --add-host lan.mgo01.prd.ams.ridesharemarket.com:192.168.33.100 --cap-add SYS_PTRACE --security-opt apparmor:unconfined ride-share-market/rsm-data:1.2.11`

## Step 5

- Build the api repo
- See the [api README.md](../../api/README.md) for database fixtures setup steps
- `curl http://192.168.33.100:8080/job/api/build?token=$CI_TOKEN`

## Step 6

- Create Docker API image and push to the private docker registry.
- `cap vbx docker:build[rsm,api,x.x.x]`

## Step 7

Deploy from Private docker registry, on the remote server(s):
 
1. Pull down the images from the private docker registry.
2. Remove any running containers in order.
3. Start containers in order.

- VBX environment
- `cap vbx docker:deploy`

### Manual Production Deployment
- SSH onto the remote app server
- `/usr/bin/env /opt/chef/embedded/bin/ruby docker-deploy.rb --env prd --hostname lan.reg01.prd.ams.ridesharemarket.com`

### Step 2 Build Option

Docker images can also be built locally (from Ubuntu workstation non-VM).

Build locally and push the application docker images to the local docker private registry
using the docker-build.sh script from within each repo.

Then deploy with capistrano as detailed above.
