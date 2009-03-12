# ====================
# Required Variables
# ====================
set :application, "set your application name here"
set :user, "seiber"
set :domain, "seiberproperties.com"

set :rails_env, "production"
set :mongrel_port, '8000'
set :mongrel_nodes, 3

# ====================
# Roles
# ====================
role :app, "your app-server here"
role :web, "your web-server here"
role :db,  "your db-server here", :primary => true

# ====================
# Respository
# ====================
default_run_options[:pty] = true
set :repository,  "git@seiberproperties.com:/home/git/seiber.git"
set :scm, "git"
set :branch, "origin/master"
set :scm_username, "git"
set :scm_password, proc{Capistrano::CLI.password_prompt('Git Password:')}
set :deploy_via, :remote_cache
set :git_shallow_clone, 1

# ====================
# SSH Options
# ====================
ssh_options[:keys] = %w(/Users/cherie/.ssh/id_rsa.pub)
ssh_options[:port] = 1027


set :deploy_to, "/home/#{user}"

set :use_sudo, true
set :run_method, :run

# ========================
# Mongrel Cluster
# ========================

namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path} && mongrel_rails cluster::configure -e production -p #{mongrel_port}0 -N #{mongrel_nodes} -c #{current_path} --user #{user} --group #{user}"
    run "cd #{current_path} && mongrel_rails cluster::start"
    run "rm -rf /home/#{user}/public_html;ln -s #{current_path}/public /home/#{user}/public_html"
    run "mkdir -p #{deploy_to}/shared/config"
    run "mv #{current_path}/config/mongrel_cluster.yml #{deploy_to}/shared/config/mongrel_cluster.yml"
    run "ln -s #{deploy_to}/shared/config/mongrel_cluster.yml #{current_path}/config/mongrel_cluster.yml"
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config.database.yml"
    run "cd #{release_path} && ln -nfs #{shared_path}/images #{release_path}/public/images"
  end

  task :restart, :roles => :app do
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config.database.yml"
    run "cd #{release_path} && ln -nfs #{shared_path}/images #{release_path}/public/images"
    run "ln -s #{deploy_to}/shared/config/mongrel_cluster.yml #{current_path}/config/mongrel_cluster.yml"
    run "cd #{current_path} && mongrel_rails cluster::restart"
  end
end