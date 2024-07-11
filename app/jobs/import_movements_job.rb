# frozen_string_literal: true

class ImportMovementsJob < ApplicationJob
  queue_as :default

  after_enqueue do |job|
    flash(type: 'info', message: I18n.t('movements.import.enqueued'), user: job.arguments.first[:user])
  end

  around_perform do |job, block|
    user = job.arguments.first[:user]

    flash(user:, type: 'warn', message: I18n.t('movements.import.started'))
    block.call
    flash(user:, type: 'notice', message: I18n.t('movements.import.success'))
  rescue StandardError
    flash(user:, type: 'alert', message: I18n.t('movements.import.failure',
                                                msg: I18n.t('movements.import.errors.generic')))
  end

  def perform(attachment_id:, user:)
    attachment = ActiveStorage::Attachment.find(attachment_id)

    attachment.open do |file|
      raw_csv = CsvReader.read(file_path: file.path)

      ActiveRecord::Base.transaction do
        raw_csv.map do |row|
          MovementBuilderDirector.new(user).build_from_csv(row).save!
        end
      end
    end

    attachment.destroy
  end
end
