require 'rvm/capistrano'
require "bundler/capistrano"
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user


require "bundler/capistrano"
load 'deploy/assets'
# main details
set :application, "blogapp"
role :web, "50.17.6.194"
role :app, "50.17.6.194"
role :db,  "50.17.6.194", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

#if ENV["development"]
#  ssh_options[:keys] = "/home/sergio/RoR/blogapp.pem"
#else
  ssh_options[:keys] = "/home/sergio/RoR/blogapp.pem"
#end
  
# ssh_options[:keys] = "/home/ubuntu/.ssh/config"
# ssh_options[:keys] = "/home/ubuntu/mobileapply.pem"
set :deploy_to, "/var/www/blogapp"
# set :deploy_via, :remote_caches
set :user, "ubuntu"
set :use_sudo, false

# repo details
set :scm, :git
set :scm_username, "ubuntu"
set :repository, "ssh://ubuntu@50.17.6.194/home/ubuntu/blogapp/.git/"
# set :local_repository, "/home/ubuntu/MobileApplyTest.git/"
set :branch, "master"
# set :git_enable_submodules, 1

# runtime dependencies
# depend :remote, :gem, "bundler", ">=1.0.0.rc.2"

# depend :remote, :gem, "bundler", ">=1.0.0.rc.2"

# tasks

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

#  desc "Restart Application"
#  task :restart, :roles => :app do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

namespace :bundler do
  desc "Symlink bundled gems on each release"
  task :symlink_bundled_gems, :roles => :app do
    run "mkdir -p #{shared_path}/bundled_gems"
    run "ln -nfs #{shared_path}/bundled_gems #{release_path}/vendor/bundle"
  end

  desc "Install for production"
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end

end

after 'deploy:update_code', 'bundler:symlink_bundled_gems'
after 'deploy:update_code', 'bundler:install'

# foreman task to stop and start from capistrano
after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'


namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run "cd #{release_path} && rvmsudo bundle exec foreman export upstart /etc/init " +
            "-a #{application} -u #{user} -l #{current_path}/log"
  end

  desc "Start the application services"
  task :start, :roles => :app do
    sudo "start #{application}"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    sudo "stop #{application}"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "sudo start #{application} || sudo restart #{application}"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end
end

