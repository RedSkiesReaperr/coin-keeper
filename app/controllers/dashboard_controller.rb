# frozen_string_literal: true

class DashboardController < ApplicationController
  include ChartConcern

  before_action :authenticate_user!

  def index # rubocop:disable Metrics/AbcSize
    @to_review_count = movements.pointed(false).count
    @total_earnings = earnings_summary.total
    @earnings_by_day = build_series(earnings_summary.by_days, key: :day, value: :amount)
    @total_expenses = expenses_summary.total
    @expenses_by_day = build_series(expenses_summary.by_days, key: :day, value: :amount)
    @year_saved_total = year_summary.saved_amount
    @year_average_saved = year_summary.average_saved_by_month
    @year_estimation = year_summary.saving_estimation
    @year_saved_by_month = build_series(year_summary.saving_by_months, key: :month, value: :amount)
  end

  private

  def target_period
    @target_period ||= current_user.user_preference.dates_range
  end

  def movements
    @movements ||= current_user.movements.ignored(false).within_date_range(target_period)
  end

  def earnings_summary
    @earnings_summary ||= MovementsSummary.new(movements: movements.incomes, period: target_period)
  end

  def expenses_summary
    @expenses_summary ||= MovementsSummary.new(movements: movements.expenses, period: target_period)
  end

  def year_summary
    @year_summary ||= YearSummary.new(movements: current_user.movements.ignored(false), year: target_period.last.year)
  end
end
