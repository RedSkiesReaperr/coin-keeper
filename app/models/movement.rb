# frozen_string_literal: true

class Movement < ApplicationRecord
  include PgSearch::Model

  belongs_to :user

  validates :date, presence: true
  validate :date, :date_cannot_be_in_the_future

  validates :label, :supplier, :amount, presence: true
  validates :pointed, :ignored, inclusion: [true, false]

  scope :pointed, ->(status) { where(pointed: status) }
  scope :ignored, ->(status) { where(ignored: status) }
  scope :within_date_range, ->(range) { where(date: range) }
  scope :incomes, -> { where('amount > ?', 0.0) }
  scope :expenses, -> { where('amount < ?', 0.0) }

  pg_search_scope :search, against: {
    label: 'A',
    supplier: 'B',
    amount: 'C',
    comment: 'D'
  }

  private

  def date_cannot_be_in_the_future
    return unless date.present? && date > Time.zone.today

    errors.add(:date, "can't be in the future")
  end
end
