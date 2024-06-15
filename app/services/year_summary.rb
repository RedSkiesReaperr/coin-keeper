# frozen_string_literal: true

class YearSummary < MovementsSummary
  def initialize(movements:, year:)
    @year_date = Date.new(year, 1, 1)

    super(movements:, period: @year_date.all_year)
  end

  def saved_amount
    amount = period_movements.sum(&:amount)

    amount.positive? ? amount : 0
  end

  def average_saved_by_month
    amounts = sum_by_months.filter_map { |row| row[:amount] if row[:amount].positive? }

    amounts.count.positive? ? (amounts.sum / amounts.count) : 0.0
  end

  def saving_estimation
    number_of_month_left = 12 - computed_months
    saving_months_ratio = saving_months_count.to_f / computed_months

    average_saved_by_month * (number_of_month_left * saving_months_ratio)
  end

  def saving_by_months
    sum_by_months.each_with_index do |row, i|
      sum_by_months[i][:amount] = 0.0 if row[:amount].negative?
    end
  end

  private

  def sum_by_months
    @sum_by_months ||= by_months
  end

  def saving_months_count
    @saving_months_count ||= sum_by_months.count { |month_row| month_row[:amount].positive? }
  end

  def computed_months
    if Time.zone.today >= @year_date.end_of_year.beginning_of_month
      12
    elsif Time.zone.today <= @year_date.beginning_of_year
      0
    else
      Time.zone.today.month
    end
  end
end
