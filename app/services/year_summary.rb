# frozen_string_literal: true

class YearSummary
  def initialize(user:, year:)
    @user = user
    @year = year
  end

  def saved_amount
    amount = movements.sum(&:amount)

    amount.positive? ? amount : 0
  end

  def average_saved_by_month
    amounts = sum_by_month.filter_map { |row| row.sum if row.sum.positive? }

    amounts.count.positive? ? (amounts.sum / amounts.count) : 0.0
  end

  def saving_estimation
    computed_months = sum_by_month.length
    number_of_month_left = 12 - computed_months
    saving_months = saving_months_count
    saving_months_ratio = saving_months.to_f / computed_months

    average_saved_by_month * (number_of_month_left * saving_months_ratio)
  end

  def saving_by_months
    sum_by_month.map do |row|
      amount = row.sum.positive? ? row.sum : 0

      { month: row.month, amount: }
    end
  end

  private

  def target_year
    @target_year ||= Date.new(@year, 1, 1)
  end

  def movements
    @movements ||= @user.movements.ignored(false).within_date_range(target_year.all_year)
  end

  def sum_by_month
    @sum_by_month ||= movements.select("DATE_TRUNC('month', date) AS month, SUM(amount) AS sum")
                               .group("DATE_TRUNC('month', date)")
                               .order('month')
  end

  def saving_months_count
    @saving_months_count ||= sum_by_month.count { |row| row.sum.positive? }
  end
end
