require 'optparse'
require "./docker_registry"

# Options
Options = Struct.new(
    :host,
    :port
)

# Option Defaults
args = Options.new(
    "reg01.dev.vbx.ridesharemarket.com",
    5000
)

# Set commandline Options
OptionParser.new do |opts|
  opts.banner = "Usage: docker_registry_latest_versions.rb [options]"

  opts.on("-nHOST", "--hostname=HOST", "Docker Private Registry hostname/IP address") do |h|
    args.host = h
  end

  opts.on("-pPORT", "--port=PORT", "Docker Private Registry port") do |p|
    args.port = p
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end.parse!

docker_registry_host = args.host
docker_registry_port = args.port

docker_registry = DockerRegistry.new({
                                         :registry_host => docker_registry_host,
                                         :registry_port => docker_registry_port
                                     })

rsm_containers = [
    "ride-share-market/rsm-logstash-forwarder",
    "ride-share-market/rsm-data",
    "ride-share-market/rsm-api",
    "ride-share-market/rsm-app",
    "ride-share-market/rsm-nginx",
]

rsm_containers.each do |item|
  puts "#{item}:#{docker_registry.get_image_current_version(item)}"
end
