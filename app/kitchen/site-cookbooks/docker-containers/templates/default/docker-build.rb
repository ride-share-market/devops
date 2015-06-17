require 'open3'
require 'optparse'

# Options
Options = Struct.new(
    :private_registry,
    :private_registry_port,
    :image_owner,
    :image_name,
    :image_version,
    :jenkins_job,
    :dry_run
)

# Option Defaults
args = Options.new(
    "reg01.dev.vbx.ridesharemarket.com",
    5000,
    "ride-share-market",
    nil,
    nil,
    nil,
    false
)

# Set commandline Options
OptionParser.new do |opts|
  opts.banner = "Usage: docker-deploy.rb [options]"

  opts.on("-nHOST", "--hostname=HOST", "Docker Private Registry hostname/IP address") do |h|
    args.private_registry = h
  end

  opts.on("-pPORT", "--port=PORT", "Docker Private Registry port") do |p|
    args.private_registry_port = p
  end

  opts.on("-oOWNER", "--owner=OWNER", "Docker image owner") do |o|
    args.image_owner = o
  end

  opts.on("-cNAME", "--name=NAME", "Docker image name") do |c|
    args.image_name = c
  end

  opts.on("-vVERSON", "--version=VERSION", "Docker image version") do |v|
    args.image_version = v
  end

  opts.on("-jJENKINSJOB", "--jenkinsjob=JENKINSJOB", "Jenkins CI jobs name") do |j|
    args.jenkins_job = j
  end

  opts.on("-d", "--dry-run", "Execute Dry Run only, print commands only") do |d|
    args.dry_run = d
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end.parse!

if args.image_name == nil
  fail "Missing required argument '--name'"
end

if args.image_version == nil
  fail "Missing required argument '--version'"
end

if args.jenkins_job == nil
  fail "Missing required argument '--jenkinsjob'"
end

private_registry = args.private_registry
private_registry_port = args.private_registry_port
image_owner = args.image_owner
image_name = args.image_name
image_version = args.image_version
jenkins_job = args.jenkins_job
dry_run = args.dry_run

def run_command(options)
  puts "==> #{options[:cmd]}"
  if !options[:dry_run]
    Dir.chdir "/var/lib/jenkins/jobs/#{options[:jenkins_job]}/workspace"
    Open3.popen3(options[:cmd]) { |stdin, stdout, stderr, wait_thr|
      while line = stdout.gets
        puts line
      end
      exit_status = wait_thr.value
      unless exit_status.success?
        #abort "==> FAILED !!! #{cmd}"
        puts "==> FAILED !!! #{options[:cmd]}"
      end
    }
  end
end

# Build
run_command({
                :dry_run => dry_run,
                :name => image_name,
                :cmd => "sudo docker build -t #{image_owner}/#{image_name}:#{image_version} .",
                :jenkins_job => jenkins_job
            })

# Tag
run_command({
                :dry_run => dry_run,
                :name => image_name,
                :cmd => "sudo docker tag #{image_owner}/#{image_name}:#{image_version} #{private_registry}:#{private_registry_port}/#{image_owner}/#{image_name}:#{image_version}",
                :jenkins_job => jenkins_job
            })

# Push
run_command({
                :dry_run => dry_run,
                :name => image_name,
                :cmd => "sudo docker push #{private_registry}:#{private_registry_port}/#{image_owner}/#{image_name}:#{image_version}",
                :jenkins_job => jenkins_job
            })
