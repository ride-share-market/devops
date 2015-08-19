user = node["secrets"]["data"]["couchbase"]["adminUser"]
pass = node["secrets"]["data"]["couchbase"]["adminPassword"]

check_file = "/home/ubuntu/docker-check_file_rsm-couchbase.txt"
if File.exists?(check_file)

  log "Aborting recipe couchbase - one time configuration on initial container instance required."
  log "Remove #{check_file} to proceed with recipe"
  return
end

execute 'couchbase_auth' do
  command "sleep 10; curl -u admin:password -d username=#{user} -d password=#{pass} -d port=8091 http://192.168.33.10:8091/settings/web"
  retries 24
  retry_delay 5
end
# curl -u admin:password -d username=Administrator -d password=123456 -d port=8091 http://192.168.33.10:8091/settings/web

execute 'couchbase_bucket' do
  command "curl -X POST -u #{user}:#{pass} -d name=oauthstate -d ramQuotaMB=100 -d authType=none -d replicaNumber=0 -d proxyPort=11212 -d flushEnabled=1 http://192.168.33.10:8091/pools/default/buckets"
  retries 24
  retry_delay 5
end
# curl -X POST -u Administrator:123456 -d name=oauthstate -d ramQuotaMB=100 -d authType=none -d replicaNumber=0 -d proxyPort=11212 -d flushEnabled=1 http://192.168.33.10:8091/pools/default/buckets

file check_file do
  action :create
end
