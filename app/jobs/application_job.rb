# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  protected

  def flash(user:, message:, type: 'default')
    Turbo::StreamsChannel.broadcast_prepend_to [user, :flashes],
                                               target: 'flashes',
                                               partial: 'layouts/flash',
                                               locals: { type:, message: }
  end
end
