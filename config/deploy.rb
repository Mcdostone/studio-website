# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "studio"
set :repo_url, "git@github.com:Mcdostone/studio-website.git"

set :rvm_ruby_version, '2.3.1p112'


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/studio"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :keep_releases, 3
