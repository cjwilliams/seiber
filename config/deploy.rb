# ====================
# Required Variables
# ====================
set :application, "seiber"
set :user, "seiber"
set :domain, "seiberproperties.com"

set :rails_env, "production"
set :mongrel_port, '8000'
set :mongrel_nodes, 3

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
set :repository,  "ssh://git@seiberproperties.com:1027/home/git/seiber.git"
set :port, '1027'
set :scm, "git"
set :branch, "master"
set :scm_username, "git"
set :scm_password, proc{Capistrano::CLI.password_prompt('Git Password:')}
set :deploy_via, :remote_cache
set :git_shallow_clone, 1

set :deploy_to, "/home/#{user}"

set :sudo, "sudo -p Password:"

# ========================
# Mongrel Cluster
# ========================
namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path} && mongrel_rails cluster::configure -e production -p #{mongrel_port} -N #{mongrel_nodes} -c #{current_path} --user #{user} --group #{user}"
    run "cd #{current_path} && mongrel_rails cluster::start"
    
    run "mkdir -p #{deploy_to}/shared/config"
    run "mv #{current_path}/config/mongrel_cluster.yml #{deploy_to}/shared/config/mongrel_cluster.yml"
    run "ln -nsf #{deploy_to}/shared/config/mongrel_cluster.yml #{release_path}/config/mongrel_cluster.yml"
    
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nsf #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
    run "ln -nsf #{shared_path}/system/items #{release_path}/public/"
  end

  task :restart, :roles => :app do
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nsf #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
    run "ln -nsf #{shared_path}/system/items #{release_path}/public/"
    run "ln -nsf #{deploy_to}/shared/config/mongrel_cluster.yml #{release_path}/config/mongrel_cluster.yml"
    run "cd #{current_path} && mongrel_rails cluster::restart"
  end
end