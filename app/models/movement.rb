# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validate :date, :date_cannot_be_in_the_future

  validates :label, :supplier, :amount, presence: true
  validates :pointed, :ignored, inclusion: [true, false]

  scope :pointed, ->(status) { where(pointed: status) }
  scope :ignored, ->(status) { where(ignored: status) }

  def self.search(query:)
    Movement.where("label LIKE :query OR supplier LIKE :query OR comment LIKE :query", query: "%#{query}%")
  end

  private

  def date_cannot_be_in_the_future
    return unless date.present? && date > Time.zone.today

    errors.add(:date, "can't be in the future")
  end
end
