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
    @period.map do |day|
      day_movements = period_movements.where(date: day)

      { day:, amount: day_movements.sum(&:amount).abs }
    end
  end

  def days
    @days ||= @period.map(&:day)
  end

  private

  def period_movements
    @period_movements ||= @movements.within_date_range(@period)
  end
end
