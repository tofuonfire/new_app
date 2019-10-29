lock "~> 3.11.2"

set :application, "mewblr"
set :repo_url, "git@github.com:tofuonfire/mewblr.git"
set :user, "nt"

set :deploy_to, "/var/www/mewblr"

set :format, :airbrussh
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :true, truncate: :false

set :pty, true

set :keep_releases, 5

set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

set :rbenv_type, :user
set :rbenv_path, '/home/nt/.rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails puma pumactl]

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/uploads'
)
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/master.key',
  '.env'
)

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      # 403 Forbidden対策
      execute 'chmod 701 /home/nt'
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'reload the database with seed data'
  task :seed do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:seed:replant DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        end
      end
    end
  end

  before :starting,     :check_revision
  before :check,        'setup:config'
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :migrate,      :seed
end

namespace :setup do
  desc 'setup config'
  task :config do
    on roles(:app) do |host|
      %w[master.key database.yml].each do |f|
        upload! "config/#{f}", "#{shared_path}/config/#{f}"
      end

      %w[.env].each do |f|
        upload! "#{f}", "#{shared_path}/#{f}"
      end
    end
  end

  desc 'setup nginx'
  task :nginx do
    on roles(:app) do |host|
      %w[mewblr.conf].each do |f|
        upload! "config/#{f}", "#{shared_path}/config/#{f}"
        sudo :cp, "#{shared_path}/config/#{f}", "/etc/nginx/conf.d/#{f}"
        sudo "nginx -s reload"
      end
    end
  end
end