# RVM bootstrap
# $:.unshift(File.expand_path("~/.rvm/lib"))
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require "bundler/capistrano"
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user


require "bundler/capistrano"
load 'deploy/assets'
# main details
set :application, "blogapp"
role :web, "ec2-50-17-6-194.compute-1.amazonaws.com"
role :app, "ec2-50-17-6-194.compute-1.amazonaws.com"
role :db,  "ec2-50-17-6-194.compute-1.amazonaws.com", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true




ssh_options[:keys] = "/Users/pramachandran/CBWorkspace/Projects/git/blogapp.pem"


  
# ssh_options[:keys] = "/home/ubuntu/.ssh/config"
# ssh_options[:keys] = "/home/ubuntu/mobileapply.pem"
set :deploy_to, "/var/www/blogapp"
# set :deploy_via, :remote_caches
set :user, "ubuntu"
set :use_sudo, false

# repo details
set :scm, :git
set :scm_username, "ubuntu"
set :repository, "ssh://ubuntu@ec2-50-17-6-194.compute-1.amazonaws.com/home/ubuntu/PraveshTest/blogapp.git"
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

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

#  task :restart, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  end

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

namespace :db do
  desc "Create Production Database"
  task :create do
    puts "\n\n=== Creating the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:create RAILS_ENV=production"
  end

  desc "Migrate Production Database"
  task :migrate do
    puts "\n\n=== Migrating the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:migrate RAILS_ENV=production"
  end

  desc "Resets the Production Database"
  task :migrate_reset do
    puts "\n\n=== Resetting the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:migrate:reset RAILS_ENV=production"
  end

  desc "Destroys Production Database"
  task :drop do
    puts "\n\n=== Destroying the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:drop RAILS_ENV=production"
  end

  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end
