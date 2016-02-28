server '198.101.243.16', :app, :web, :primary => true
set :user, "kibind"
set :port, 1865
set :rails_env, 'test'
set :deploy_to, "/var/www/sysand"
set :branch, "master"

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:assets_precompile"
after "deploy:assets_precompile", "deploy:restart"