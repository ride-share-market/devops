## Jenkins CI

The chef run will setup the application jobs, but you'll need to enter Jenkins admin
and do some manual configuration updates (for now).

### Configuration and Authentication

Open up the Web UI enable these three options: 

- *System*
- Jenkins > Manage Jenkins > Configure System > # of executors (set this to one for VM)
- Jenkins > Manage Jenkins > Configure System > Ant (set to Ant 1.9.5)
- *Security*
- Jenkins > Manage Jenkins > Configure Global Security > Enable security
- Access Control > Security Realm > Jenkins' own user database 
- Access Control > Security Realm > Allow users to sign up **DISABLE**
- Access Control > Authorization > Logged-in users can do anything Security Realm
 
### Plugins and Jobs

- Install custom plugins
- `sudo docker exec rsm-jenkins sh /var/jenkins_home/jobs-xml/jenkins_install_plugins.sh`
- Create CI jobs
- `sudo docker exec rsm-jenkins sh /var/jenkins_home/jobs-xml/jenkins_create_jobs.sh`
- *Update all the installed plugins*
- Jenkins > Manage Jenkins > Manage Plugins - *Restart Jenkins when installation is complete and no jobs are running*
