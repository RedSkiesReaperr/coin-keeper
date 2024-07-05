# frozen_string_literal: true

require 'sidekiq/api'

namespace :sidekiq do
  task clear: :environment do
    Sidekiq::RetrySet.new.clear # Clear retry set
    Sidekiq::ScheduledSet.new.clear # Clear scheduled jobs
    Sidekiq::DeadSet.new.clear # Clear 'Dead' jobs statistics
    Sidekiq::Stats.new.reset # Clear 'Processed' and 'Failed' jobs statistics
    Sidekiq::Queue.all.map(&:clear) # Clear all queues
  end
end
