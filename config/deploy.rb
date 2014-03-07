# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'nsci'
set :repo_url, 'git@git.internal.vmp.ru:ajieks/auth-center.git'

set :deploy_to, '/opt/www/nsci'
set :scm, :git

set :deploy_via, :remote_cache

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/mongoid.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/assets}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :unicorn do
  pid_path = "#{release_path}/tmp/pids"
  unicorn_pid = "#{pid_path}/unicorn.pid"

  def run_unicorn
    execute "#{fetch(:bundle_binstubs)}/unicorn", "-c #{release_path}/config/unicorn.rb -D -E #{fetch(:stage)}"
  end

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      run_unicorn
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-QUIT `cat #{unicorn_pid}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-9 `cat #{unicorn_pid}`"
        execute :rm, unicorn_pid
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-USR2 `cat #{unicorn_pid}`"
      else
        run_unicorn
      end
    end
  end
end


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
    end
  end

  before :finishing, :create_tmp do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, 'tmp:create'
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :bundle, 'exec', 'rake', 'tmp:clear'
      end
    end
  end

  before :symlink, :upload_config do
    on roles(:all) do
      execute "mkdir  #{shared_path}/config/"

      upload!('shared/mongoid.yml', "#{shared_path}/config/mongoid.yml")
      upload!('shared/provider.yml', "#{shared_path}/config/provider.yml")

    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'unicorn:restart'

end
