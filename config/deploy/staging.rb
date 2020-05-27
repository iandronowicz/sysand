server 'admin.androvial.com.ar', :app, :web, :primary => true
set :user, "homer"
set :port, 22
set :rails_env, 'production'
set :deploy_to, "/var/www/sysand"
set :branch, "master"

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:assets_precompile"
after "deploy:assets_precompile", "deploy:restart"
