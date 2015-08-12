## Chef server usage notes

### Reset all chef server cookbooks - delete all, then upload all

- Delete all cookbooks
- `knife cookbook bulk delete ".*" -p`
- Upload all cookbooks
- `knife cookbook upload --all`

### Single cookbook
- Upload
- `knife cookbook upload --include-dependencies network-hosts-prd`

### Example Node Run List Management
- `knife node list`
- `knife node show redline`

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

- Run all cookbooks
- `sudo -u root -i chef-client`
- Run selected cookbooks
- `sudo -u root -i chef-client --override-runlist firehol-prd`
