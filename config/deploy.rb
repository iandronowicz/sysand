require "rvm/capistrano"
require "bundler/capistrano"
require "capistrano/ext/multistage"

set :stages, %w(staging)
set :default_stage, "staging"

set :application, "sysand"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :repository,  "git@github.com:iandronowicz/sysand.git"
set :scm, :git
set :user_sudo, false
set :deploy_via, :remote_cache

set :default_environment, {
  'PATH' => "$PATH:/usr/local/bin"
}

namespace :deploy do
	task :bundle_gems do
		run "cd #{deploy_to}/current && bundle install"
	end
	task :assets_precompile do
		run "cd #{deploy_to}/current && bundle exec rake assets:precompile"
	end
	task :start do ; end
	task :stop do ; end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "touch #{File.join(current_path,'tmp','restart.txt')}"
	end
	task :mig, :roles => :app, :except => { :no_release => true } do
		run "cd #{deploy_to}/current && rake RAILS_ENV=production db:migrate"
	end
end
