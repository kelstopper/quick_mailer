# config valid only for current version of Capistrano
lock '3.7.1'

set :application, 'event_mailer'
set :repo_url, 'git@github.com:kelstopper/quick_mailer.git'
set :branch, 'master'

set :puma_threads, [4, 16]
set :puma_workers, 0

set :puma_monit_conf_dir, -> { "/etc/monit.d/#{puma_monit_service_name}" }
set :puma_monit_use_sudo, true
set :puma_monit_bin, '/bin/monit'

set :linked_files, %w(config/config.yml)
set :linked_dirs, %w(log tmp)

set :keep_releases, 3

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
end

before 'deploy:check', 'puma:make_dirs'
