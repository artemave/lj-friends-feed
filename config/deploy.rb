require 'bundler/capistrano'

set :application, "lj-friends-feed"
set :repository,  "https://github.com/artemave/lj-friends-feed.git"

set :scm, :git

set :use_sudo, false

# This is needed to correctly handle sudo password prompt
default_run_options[:pty] = true

set :user, "oompa"

server "198.199.106.44", :app, :web, :db, primary: true

set :rails_env, :production

set :deploy_to, "/home/#{user}/projects/#{application}"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :thin_servers, 1
set :thin_host, '0.0.0.0'
set :thin_port, 4000
require 'capistrano-thin'

after "deploy:restart", "deploy:cleanup"
