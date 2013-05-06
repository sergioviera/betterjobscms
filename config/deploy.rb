require "bundler/capistrano"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = "publickey"
ssh_options[:keys] = ["/blogapp.pem"]

set :application, "blogapp"
set :repository, "git@github.com:sergioviera/betterjobscms.git"  # Your clone URL
set :scm, "git"
set :user, "sergioviera"  # The server's user for deploys
#set :scm_passphrase, "f10r1n00"  # The deploy user's password

set :ssh_options, { :forward_agent => true }
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "http://ec2-50-17-6-194.compute-1.amazonaws.com/"                          # Your HTTP server, Apache/etc
role :app, "http://ec2-50-17-6-194.compute-1.amazonaws.com/"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :branch, "master"
set :deploy_via, :remote_cache

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
