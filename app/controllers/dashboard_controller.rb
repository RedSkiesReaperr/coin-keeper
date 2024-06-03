# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_earnings = movements.incomes.sum(:amount)
    @total_expenses = movements.expenses.sum(:amount)
    @year_saved_total = year_summary.saved_amount
    @year_average_saved = year_summary.average_saved_by_month
    @year_estimation = year_summary.saving_estimation
    @year_saved_by_month = [year_summary.saving_by_months]
    @year_saved_by_month_labels = @year_saved_by_month.first&.map do |row|
      Date::MONTHNAMES.compact[row[:month].month - 1]
    end
  end

  private

  def target_year
    Time.zone.today
  end

  def movements
    @movements ||= current_user.movements.ignored(false)
  end

  def year_summary
    @year_summary ||= YearSummary.new(user: current_user, year: target_year.year)
  end
end
