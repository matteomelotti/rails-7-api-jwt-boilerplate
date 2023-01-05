require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq.default_worker_options = { 'backtrace' => true }

url = 'redis://default:ao0fl8zrz49jw2qx@localhost:8000/0'

sidekiq_redis_options = { url: url }
sidekiq_redis_options.merge! driver: :hiredis

Sidekiq.configure_client do |config|
  config.redis = sidekiq_redis_options
end

# initializers/sidekiq.rb

schedule_file = 'config/schedule.yml'

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?

run Sidekiq::Web
