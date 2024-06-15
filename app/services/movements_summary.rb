# frozen_string_literal: true

class MovementsSummary
  def initialize(movements:, period:)
    @movements = movements
    @period = period
  end

  def total
    period_movements.sum(&:amount)
  end

  def by_days
    @period.map { |day| { day:, amount: period_amounts[day]&.abs || 0.0 } }
  end

  private

  def period_movements
    @period_movements ||= @movements.within_date_range(@period).order(date: :asc)
  end

  def period_amounts
    @period_amounts ||= period_movements.group(:date).sum(:amount)
  end
end
