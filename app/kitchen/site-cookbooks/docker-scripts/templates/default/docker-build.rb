require 'open3'
require 'optparse'

# Options
Options = Struct.new(
    :env,
    :private_registry,
    :private_registry_port,
    :image_owner,
    :image_prefix,
    :image_version,
    :jenkins_job,
    :dry_run,
    :abort_on_error
)

# Option Defaults
args = Options.new(
    nil,
    "reg01.dev.vbx.ridesharemarket.com",
    5000,
    "ride-share-market",
    nil,
    nil,
    nil,
    false,
    false
)

# Set commandline Options
OptionParser.new do |opts|
  opts.banner = "Usage: docker-deploy.rb [options]"

  opts.on("-eENV", "--env=ENV", "Node application environment") do |e|
    args.env = e
  end

  opts.on("-nHOST", "--hostname=HOST", "Docker Private Registry hostname/IP address") do |h|
    args.private_registry = h
  end

  opts.on("-pPORT", "--port=PORT", "Docker Private Registry port") do |p|
    args.private_registry_port = p
  end

  opts.on("-oOWNER", "--owner=OWNER", "Docker image owner") do |o|
    args.image_owner = o
  end

  opts.on("-cPREFIX", "--prefix=PREFIX", "Docker image prefix") do |c|
    args.image_prefix = c
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

  opts.on("-a", "--abort-on-error", "Abort script execution on any error") do |a|
    args.abort_on_error = a
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end.parse!

if args.env == nil
  fail "Missing required argument '--env'"
end

if args.image_prefix == nil
  fail "Missing required argument '--prefix'"
end

if args.jenkins_job == nil
  fail "Missing required argument '--jenkinsjob'"
end

if args.image_version == nil
  fail "Missing required argument '--version'"
end

application_env = args.env
private_registry = args.private_registry
private_registry_port = args.private_registry_port
image_owner = args.image_owner
image_prefix = args.image_prefix
image_version = args.image_version
jenkins_job = args.jenkins_job
dry_run = args.dry_run
abort_on_error = args.abort_on_error

def run_command(options)
  puts "==> #{options[:cmd]}"
  if !options[:dry_run]

    work_dir = "/home/jenkins/workspace/#{options[:jenkins_job]}"

    Dir.chdir work_dir

    Open3.popen3(options[:cmd]) { |stdin, stdout, stderr, wait_thr|
      while line = stdout.gets
        puts line
      end
      exit_status = wait_thr.value
      unless exit_status.success?
        message = "==> FAILED !!! #{options[:cmd]}"
        if options[:abort_on_error]
          abort message
        else
          puts message
        end
      end
    }
  end
end

# Set Logrotate restart env
run_command({
                :application_env => application_env,
                :dry_run => dry_run,
                :abort_on_error => abort_on_error,
                :cmd => "if [ -e config/logrotate.conf ]; then sudo sed -i.orig -e 's/NODE_ENV=[a-z]\\{3\\}/NODE_ENV=#{application_env}/g' config/logrotate.conf; fi",
                :jenkins_job => jenkins_job
            })

# Build
run_command({
                :application_env => application_env,
                :dry_run => dry_run,
                :abort_on_error => abort_on_error,
                :cmd => "sudo docker build -t #{image_owner}/#{image_prefix}-#{jenkins_job}:#{image_version} .",
                :jenkins_job => jenkins_job
            })

# Tag
run_command({
                :application_env => application_env,
                :dry_run => dry_run,
                :abort_on_error => abort_on_error,
                :cmd => "sudo docker tag #{image_owner}/#{image_prefix}-#{jenkins_job}:#{image_version} #{private_registry}:#{private_registry_port}/#{image_owner}/#{image_prefix}-#{jenkins_job}:#{image_version}",
                :jenkins_job => jenkins_job
            })

# Push
run_command({
                :application_env => application_env,
                :dry_run => dry_run,
                :abort_on_error => abort_on_error,
                :cmd => "sudo docker push #{private_registry}:#{private_registry_port}/#{image_owner}/#{image_prefix}-#{jenkins_job}:#{image_version}",
                :jenkins_job => jenkins_job
            })
