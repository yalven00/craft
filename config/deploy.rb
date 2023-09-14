set :user, "craft"
server "107.170.226.21", user: fetch(:user), roles: %w{web app db}
set :repo_url, "git@github.com:muso19/MyCareerPal.git"
set :application, 'craft.co'
set :deploy_to, -> {"/home/#{fetch(:user)}/#{fetch(:application)}/#{fetch(:stage)}"}
set :unicorn_workers, 1
set :keep_releases, 5
set :linked_dirs, fetch(:linked_dirs) + (%w(log tmp/pids system))
set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }
set :pty, true
set :rvm_ruby_string, 'ruby-2.0@craft'


task :production do
  set :bundle_without, [:development, :test]
end

task :staging do
  set :bundle_without, :test
end

# require 'capistrano'

# namespace :load do
#   task :defaults do
#     set :templates_path, "config/deploy/templates"

#     set :nginx_server_name, -> { "www.example.com" }
#     set :nginx_use_ssl, false
#     set :nginx_ssl_certificate, -> { "#{fetch(:nginx_server_name)}.crt" }
#     set :nginx_ssl_certificate_key, -> { "#{fetch(:nginx_server_name)}.key" }
#     set :nginx_upload_local_certificate, -> { true }
#     set :nginx_ssl_certificate_local_path, -> { "/etc/certificates/" }
#     set :nginx_ssl_certificate_key_local_path, -> { "/etc/certificates/keys" }

#     set :unicorn_pid, -> { "#{current_path}/tmp/pids/unicorn.pid" }
#     set :unicorn_config, -> { "#{shared_path}/config/unicorn.rb" }
#     set :unicorn_log, -> { "#{shared_path}/log/unicorn.log" }
#     set :unicorn_user, -> { fetch(:user) }
#     set :unicorn_workers, 4
#   end
# end

# namespace :nginx do
#   desc "Setup nginx configuration for this application"
#   task :setup do
#     on roles(:web) do
#       template("nginx_conf.erb", "/tmp/#{fetch(:application)}_#{fetch(:stage)}.conf")
#       execute "sudo mv /tmp/#{fetch(:application)}_#{fetch(:stage)}.conf /etc/nginx/sites-available/#{fetch(:application)}_#{fetch(:stage)}.conf"
#       execute "sudo ln -fs /etc/nginx/sites-available/#{fetch(:application)}_#{fetch(:stage)}.conf /etc/nginx/sites-enabled/#{fetch(:application)}_#{fetch(:stage)}.conf"

#       if fetch(:nginx_use_ssl)
#         if nginx_upload_local_certificate
#           put File.read(nginx_ssl_certificate_local_path), "/tmp/#{fetch(:nginx_ssl_certificate)}"
#           put File.read(nginx_ssl_certificate_key_local_path), "/tmp/#{fetch(:nginx_ssl_certificate_key)}"

#           execute "sudo mv /tmp/#{fetch(:nginx_ssl_certificate)} /etc/ssl/certs/#{fetch(:nginx_ssl_certificate)}"
#           execute "sudo mv /tmp/#{fetch(:nginx_ssl_certificate_key)} /etc/ssl/private/#{fetch(:nginx_ssl_certificate_key)}"
#         end

#         execute "sudo chown root:root /etc/ssl/certs/#{fetch(:nginx_ssl_certificate)}"
#         execute "sudo chown root:root /etc/ssl/private/#{fetch(:nginx_ssl_certificate_key)}"
#       end
#     end
#   end
# end

# namespace :unicorn do
#   desc "Setup Unicorn initializer and app configuration"
#   task :setup do
#     on roles(:app) do
#       execute "mkdir -p #{shared_path}/config"
#       execute "mkdir -p #{shared_path}/tmp/pids"
#       template "unicorn.rb.erb", fetch(:unicorn_config)
#       template "unicorn_init.erb", "/tmp/unicorn_init"
#       execute "chmod +x /tmp/unicorn_init"
#       execute "sudo mv /tmp/unicorn_init /etc/init.d/unicorn_#{fetch(:application)}_#{fetch(:stage)}"
#       execute "sudo update-rc.d -f unicorn_#{fetch(:application)}_#{fetch(:stage)} defaults"
#     end
#   end
#   after "deploy:check", "unicorn:setup"
# end

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command do
      on roles(:app) do
        execute "service unicorn_#{fetch(:application)}_#{fetch(:stage)} #{command}"
      end
    end
  end
  after :publishing, "deploy:restart"
  after :finished, 'sidekiq:restart'
end

# desc "Setup logs rotation for nginx and unicorn"
# task :logrotate do
#   on roles(:web, :app) do
#     template("logrotate.erb", "/tmp/#{fetch(:application)}_#{fetch(:stage)}_logrotate")
#     execute "sudo mv /tmp/#{fetch(:application)}_#{fetch(:stage)}_logrotate /etc/logrotate.d/#{fetch(:application)}_#{fetch(:stage)}"
#     execute "sudo chown root:root /etc/logrotate.d/#{fetch(:application)}_#{fetch(:stage)}"
#   end
# end

# after "deploy:check", "logrotate"
