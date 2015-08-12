docker_images = %w(rabbitmq:3.5.4-management elasticsearch:1.7.1 logstash:1.5.2 kibana:4.1.1)

# Images
docker_images.each do |image|
  docker_image image do
    action :pull_if_missing
    # 30 minute timeout allows for slow local env developer connections
    cmd_timeout 1800
  end
end
