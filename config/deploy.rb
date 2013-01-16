# ====================
# Required Variables
# ====================
set :application, "seiber"
set :domain, "seiberproperties.com"
set :user, "seiber"

set :rails_env, "production"

# ====================
# Roles
# ====================
role :app, domain
role :web, domain
role :db,  domain, :primary => true


# ====================
# Respository
# ====================
default_run_options[:pty] = true

set :scm, "git"
set :port, '1027'
set :repository, "ssh://git@#{domain}:#{port}/home/git/#{application}.git"
set :branch, "master"

set :scm_username, "git"
set :scm_password, proc{Capistrano::CLI.password_prompt('Git Password:')}
set :git_shallow_clone, true

set :deploy_to, "/home/#{user}"
set :deploy_via, :remote_cache

set :use_sudo, false

# ====================
# Phusion Passenger
# ====================
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/images #{release_path}/public/images"
    run "ln -nfs #{shared_path}/gems #{release_path}/vendor/gems"
    run "ln -nfs #{shared_path}/rails #{release_path}/vendor/rails"
    run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
  end
  
  desc "Sync the public/assets directory."
  task :images do
    system "rsync -vr --exclude='.DS_Store' --rsh='ssh -p1027' public/images #{user}@#{domain}:#{shared_path}"
  end
  
  desc "Sync the vendored gems directories"
  task :gems do
    system "rsync -vr --exclude='.DS_Store' --rsh='ssh -p1027' vendor/gems #{user}@#{domain}:#{shared_path}"
    system "rsync -vr --exclude='.DS_Store' --rsh='ssh -p1027' vendor/rails #{user}@#{domain}:#{shared_path}"
  end
  
  task :setup_production_database_configuration do
     database_password = Capistrano::CLI.password_prompt("Production Database password: ")
     require 'yaml'
     spec = { "production" => {
       "adapter" => "sqlite3",
       "database" => "db/production.sqlite3",
       "username" => user,
       "password" => database_password } }
     run "mkdir -p #{shared_path}/config"
     put(spec.to_yaml, "#{shared_path}/config/database.yml")
  end
end
 
after 'deploy:update_code', 'deploy:symlink_shared'
after "deploy:setup", 'deploy:setup_production_database_configuration'