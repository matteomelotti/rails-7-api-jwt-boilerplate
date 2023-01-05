if defined?(Sidekiq)
  puts 'Setup sidekiq'

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1') }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1') }
  end

  Rails.application.config.active_job.queue_adapter = :sidekiq

  # initializers/sidekiq.rb

  schedule_file = 'config/schedule.yml'

  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
end

require 'sidekiq/web'
require 'sidekiq/cron/web'
