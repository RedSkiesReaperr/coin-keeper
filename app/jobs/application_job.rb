# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  protected

  def notify(user:, message:, type: 'default')
    Turbo::StreamsChannel.broadcast_prepend_to [user, :notifications],
                                               target: 'flash',
                                               partial: 'layouts/notification',
                                               locals: { type:, message: }
  end
end
