## Chef server usage notes

## Data Bags

### Secrets

- Initial only
- `knife data bag create secrets`
- Initial **and** Update
- `knife data bag from file secrets data_bags/secrets/secrets.json`

### Network

- Initial only
- `knife data bag create network`
- Initial **and** Update
- `knife data bag from file network file data_bags/network/prd_aws_ridesharemarket.json`

## Cookbooks

### Reset all chef server cookbooks - delete all, then upload all

- Delete all cookbooks
- `knife cookbook bulk delete ".*" -p`
- Upload all cookbooks
- `knife cookbook upload --all`

### Single cookbook
- Upload
- `knife cookbook upload --include-dependencies network-hosts-prd`

### Run chef-client from command line on server

- Run all cookbooks
- `sudo -u root -i chef-client`
- Run selected cookbooks
- `sudo -u root -i chef-client --override-runlist network-hosts-prd`

### Node Run List Management
- `knife node list`
- `knife node show trumpet`
- `knife node show mandolin`

### Trumpet (Data)

- `knife node run_list add trumpet docker-wrapper-prd`
- `knife node run_list add trumpet docker-prometheus-prd`
- `knife node run_list add trumpet docker-relk-prd`
- `knife node run_list add trumpet docker-lumberjack`
- `knife node run_list add trumpet docker-lumberjack-prd::node_exporter`
- `knife node run_list add trumpet docker-private-registry-prd`
- `knife node run_list add trumpet docker-couchbase-prd`
- `knife node run_list add trumpet docker-mongodb`
- `knife node run_list add trumpet docker-jenkins`
- `knife node run_list add trumpet docker-scripts-prd`
- `knife node run_list add trumpet docker-scripts-prd::ci_server`
- `knife node run_list add trumpet cron-jobs::ci_server`

knife node run_list add trumpet docker-scripts-prd docker-scripts-prd::ci_server cron-jobs::ci_server

# Todo: single line run_list add

### Mandolin (APP)

- `knife node run_list add mandolin docker-wrapper-prd`
- `knife node run_list add mandolin docker-lumberjack`
- `knife node run_list add mandolin docker-lumberjack::ssl`
- `knife node run_list add mandolin docker-lumberjack-prd::node_exporter`
- `knife node run_list add mandolin docker-prometheus::node-exporter`
- `knife node run_list add mandolin docker-prometheus::container-exporter`
- `knife node run_list add mandolin docker-scripts-prd`
- `knife node run_list add mandolin docker-scripts-prd::app_server`

knife node run_list add mandolin docker-wrapper-prd docker-lumberjack docker-lumberjack::ssl docker-lumberjack-prd::node_exporter docker-prometheus::node-exporter docker-prometheus::container-exporter docker-scripts-prd docker-scripts-prd::app_server

# Todo: single line run_list add

**Legacy to be removed.**

### Redline (Data + App)

- Add cookbooks one by one
- `knife node run_list add redline git-repos`
- `knife node run_list add redline docker-wrapper-prd`
- `knife node run_list add redline docker-relk-prd`
- `knife node run_list add redline docker-prometheus`
- `knife node run_list add redline docker-grafana`
- `knife node run_list add redline docker-containers-prd`
- `knife node run_list add redline mongodb`
- `knife node run_list add redline jenkins-cookbook`
- `knife node run_list add redline cron-jobs`

- Add all cookbooks
- `knife node run_list add redline git-repos,docker-wrapper-prd,docker-relk-prd,docker-prometheus,docker-grafana,docker-containers-prd,mongodb,jenkins-cookbook,cron-jobs`
