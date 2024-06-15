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

  def by_months
    months_ranges.map do |month_range|
      amount = period_amounts.sum { |day, value| month_range.cover?(day) ? value : 0.0 }

      { month: month_range.first.beginning_of_month, amount: }
    end
  end

  protected

  def period_movements
    @period_movements ||= @movements.within_date_range(@period).order(date: :asc)
  end

  private

  def period_amounts
    @period_amounts ||= period_movements.group(:date).sum(:amount)
  end

  def months_ranges
    @months_ranges ||= @period.group_by(&:month).map { |_, days| days.first..days.last }
  end
end
