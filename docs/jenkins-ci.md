## Jenkins CI

The chef run will setup the application jobs, but you'll need to enter Jenkins admin
and do some manual configuration updates (for now).

### Authentication

The chef run will setup the jobs and user accounts but Auth needs to be turned on manually.

From the web UI enable these three options: 

- Jenkins > Manage Jenkins > Configure System > # of executors (set this to one for VM)
- Jenkins > Manage Jenkins > Configure System > Ant (set to Ant 1.9.5)
- Jenkins > Manage Jenkins > Configure Global Security > Enable security
- Access Control > Security Realm > Jenkins' own user database 
- Access Control > Authorization > Logged-in users can do anything Security Realm
 
### Plugins and Jobs
 
- Jenkins > Manage Jenkins > Manage Plugins (Update all the installed plugins)
- Re-run Chef on the CI node so it will update the Jenkins jobs that need the previous updates.
- vbx environment
- `./devops.rb cook`
- prd environment
- `sudo -u root -i chef-client --override-runlist jenkins-cookbook`
