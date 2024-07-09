# frozen_string_literal: true

class UserPreference < ApplicationRecord
  belongs_to :user

  validates :start_date, :end_date, presence: true
  validate :start_date, :start_date_cannot_be_after_end_date
  validate :end_date, :end_date_cannot_be_before_start_date

  def dates_range
    start_date..end_date
  end

  private

  def start_date_cannot_be_after_end_date
    return unless start_date.present? && end_date.present? && start_date > end_date

    errors.add(:start_date, "can't be after end date")
  end

  def end_date_cannot_be_before_start_date
    return unless start_date.present? && end_date.present? && end_date < start_date

    errors.add(:end_date, "can't be before start date")
  end
end
