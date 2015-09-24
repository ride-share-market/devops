# Application Deployment

## Overview

The Ride Share Market application is split into two parts (currently) - Data and App.

Each of these parts is deployed as a cluster of Docker containers.

Each Docker cluster, or Pod, can be made up of one or more micro services.

*Prerequisites*:

1. Jenkins CI server setup with application repos (configuration management should have done this).

## Step 1

Copy private JSON configuration files for each micro service from developer workstation to the CI server.

These JSON config files are not in the github repository for security purposes.

- `cd ride-share-market/devops/app`
- **VBX**
- `cap vbx docker:upload_config`
- **PRD**
- `cap prd docker:upload_config`

 
## Step 2

Build repos on the CI server.

The **api** repo requires a running rsm-data container, as it has some database integration tests.

So we'll build the **api** repo last.

- `zsh` shell
- `export CI_TOKEN=GET-TOKEN-FROM-KEEPASS-SECRETS-JSON`
- Build repos, the first node app will download iojs.
- **VBX**
- `for JOB (nginx iojs data app) { curl "http://192.168.33.100:8080/job/$JOB/build?token=$CI_TOKEN" }`
- **PRD**
- `for JOB (nginx iojs data app) { curl "http://lan.trumpet:8080/job/$JOB/build?token=$CI_TOKEN" }`

## Step 3

Create Docker Images and push to the private docker registry.

Build each image one by one - *use the current passing CI build version*.

Note: **No spaces** in capistrano command arguments.

- **VBX**
- `cap vbx docker:build[rsm,iojs,x.x.x]`
- `cap vbx docker:build[rsm,nginx,x.x.x]` 
- `cap vbx docker:build[rsm,data,x.x.x]`
- `cap vbx docker:build[rsm,app,x.x.x]` 

- **PRD**
- `cap prd docker:build[rsm,iojs,x.x.x]`
- `cap prd docker:build[rsm,nginx,x.x.x]` 
- `cap prd docker:build[rsm,data,x.x.x]`
- `cap prd docker:build[rsm,app,x.x.x]`

## Step 4

- Deploy the Data Pod (rsm-data container):
- `cap vbx docker:deploy[data]`
- OR
- `cap prd docker:deploy[data]`

## Step 5

- Build the api repo
- See the [api README.md](../../api/README.md) for database fixtures setup steps
- **VBX**
- `curl http://192.168.33.100:8080/job/api/build?token=$CI_TOKEN`
- **PRD**
- `curl http://lan.trumpet:8080/job/api/build?token=$CI_TOKEN`

## Step 6

- Create Docker API image and push to the private docker registry.
- **VBX**
- `cap vbx docker:build[rsm,api,x.x.x]`
- **PRD**
- `cap prd docker:build[rsm,api,x.x.x]`

## Step 7

Deploy the App Pod:

1. Pull down the images from the private docker registry.
2. Remove any running containers in order.
3. Start containers in order.

- **VBX**
- `cap vbx docker:deploy[app]`
- **PRD**
- `cap prd docker:deploy[app]`
