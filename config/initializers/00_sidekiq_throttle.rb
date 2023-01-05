require "sidekiq/throttled"
Sidekiq::Throttled::Registry.add(:heavy_jobs, concurrency: { limit: 1, ttl: 5.hour.to_i })
Sidekiq::Throttled.setup!