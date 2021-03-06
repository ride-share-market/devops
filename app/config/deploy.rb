# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ridesharemarket.com'
# set :repo_url, 'git@example.com:me/my_repo.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

set :ssh_options, {forward_agent: true}

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {path: "/opt/chef/embedded/bin:$PATH"}

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

desc "Report Uptimes"
task :uptime do
  on roles(:all) do |host|
    execute "uptime"
    info "Host #{host} (#{host.roles.to_a.join(", ")}):\t#{capture(:uptime)}"
  end
end

set :rsm_configs, fetch(:rsm_configs, []).push(
                    {
                        name: "data",
                        config_src: Dir.glob(File.join(File.dirname(__FILE__), "/../../../data/config/env/*.json")),
                        config_dst: "/home/jenkins/jobs-config/data/config/env"
                    },
                    {
                        name: "api",
                        config_src: Dir.glob(File.join(File.dirname(__FILE__), "/../../../api/config/env/*.json")),
                        config_dst: "/home/jenkins/jobs-config/api/config/env"
                    },
                    {
                        name: "app",
                        config_src: Dir.glob(File.join(File.dirname(__FILE__), "/../../../app/config/env/*.json")),
                        config_dst: "/home/jenkins/jobs-config/app/config/env"
                    },
                    {
                        name: "nginx",
                        config_src: Dir.glob(File.join(File.dirname(__FILE__), "/../../../nginx/ssl/*")),
                        config_dst: "/home/jenkins/jobs-config/nginx/ssl"
                    }

                )

namespace :docker do

  desc "Upload App Config"
  task :upload_config do

    on roles(:cis) do |host|

      puts "==> Host: #{host}"

      puts "==> Stage: #{fetch(:stage)}"

      if fetch(:stage).to_s == "vbx"
        user = "vagrant"
      else
        user = "ubuntu"
      end

      puts "==> User: #{user}"

      as user do
        within "/home/jenkins" do

          fetch(:rsm_configs, []).each do |rsm_config|

            if test "[ ! -d #{rsm_config[:config_dst]} ]"
              execute :mkdir, "-p", rsm_config[:config_dst]
            end

            rsm_config[:config_src].each do |file|
              # The upload!() method doesn't honor the values of within(), as() etc, this will be improved
              # as the library matures, but we're not there yet.
              # upload! file, rsm_config[:config_dst]
              on(:local) do
                execute :scp, "#{file} #{user}@#{host}:#{rsm_config[:config_dst]}"
              end
            end

          end

        end

      end
    end
  end

  desc "Docker Build"
  task :build, :prefix, :jenkins_job, :version do |t, args|
    on roles(:cis) do |host|
      execute "/opt/chef/embedded/bin/ruby docker-build.rb --env #{fetch(:stage)} --hostname #{fetch(:private_docker_registry)} --prefix #{args[:prefix]} -j #{args[:jenkins_job]} --version #{args[:version]}"
      info "Host #{host} (#{host.roles.to_a.join(", ")}):\t#{capture(:uptime)}"
    end
  end

  desc "Docker Deploy"
  task :deploy, :pod do |t, args|

    raise "Argument pod required. Ex: 'cap vbx docker:deploy[app]'" if !args[:pod]

    if args[:pod] == "app"
      on roles(:app) do |host|
        execute "/opt/chef/embedded/bin/ruby docker-deploy.rb --env #{fetch(:stage)} --pod app --hostname #{fetch(:private_docker_registry)}"
        info "Host #{host} (#{host.roles.to_a.join(", ")}):\t#{capture(:uptime)}"
      end
    end

    if args[:pod] == "data"
      on roles(:cis) do |host|
        execute "/opt/chef/embedded/bin/ruby docker-deploy.rb --env #{fetch(:stage)} --pod data --hostname #{fetch(:private_docker_registry)}"
        info "Host #{host} (#{host.roles.to_a.join(", ")}):\t#{capture(:uptime)}"
      end
    end

  end

end