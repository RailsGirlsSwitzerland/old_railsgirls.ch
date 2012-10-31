require 'bundler/capistrano'
require 'capistrano/ext/multistage'
# require 'new_relic/recipes'
require "rvm/capistrano"                               # Load RVM's capistrano plugin.
# require "whenever/capistrano"

# set :whenever_command, "bundle exec whenever"
# set :whenever_environment, defer { stage }
# set :whenever_identifier, defer { "#{application}_#{stage}" }

set :application, "railsgirls"
set :rails_env, 'production'
set :deploy_via, :remote_cache
set :scm, :git
set :default_run_options, {:pty => true}
set :repository, "git@git.silvermind.ch:railsgirls.ch.git"
set :ssh_options, {:forward_agent => true}
set :use_sudo, true
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system  # Copy the exact line. I really mean :system here
set :rvm_install_type, :stable


task :update_config_links, :roles => [:app] do
  run "ln -sf #{shared_path}/config/* #{release_path}/config/"
  run "ln -sf #{shared_path}/bundle #{release_path}/vendor/"
end
before 'deploy:assets:precompile', :update_config_links

# Overwrite deployment methods
# deploy:start and deploy:stop aren't needed as they're handled by passenger
# deploy:restart is realized though updating the timestamp in ./tmp/restart.txt'
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy", "deploy:cleanup"

# new relic deployment hook
# after "deploy:update", "newrelic:notice_deployment"