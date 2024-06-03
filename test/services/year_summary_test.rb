# frozen_string_literal: true

require 'test_helper'

class YearSummaryTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @movements = [
      # January
      create(:movement, user: @user, date: Date.new(2024, 1, 10), amount: -931.07, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 1, 22), amount: -25.43, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 1, 24), amount: 488.95, ignored: false),
      # February
      create(:movement, user: @user, date: Date.new(2024, 2, 1), amount: -707.38, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 2, 3), amount: -609.83, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 2, 4), amount: 762.05, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 2, 5), amount: 188.49, ignored: false),
      # March
      create(:movement, user: @user, date: Date.new(2024, 3, 8), amount: -965.43, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 3, 18), amount: 840.39, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 3, 20), amount: 779.08, ignored: false),
      # April
      create(:movement, user: @user, date: Date.new(2024, 4, 6), amount: 598.26, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 4, 16), amount: 902.43, ignored: false),
      create(:movement, user: @user, date: Date.new(2024, 4, 23), amount: -297.72, ignored: false)
    ]
  end

  test '.saved_amount returns overall saved amount' do
    assert_equal 1022.79, YearSummary.new(user: @user, year: 2024).saved_amount
  end

  test '.average_saved_by_month returns the average' do
    assert_equal 928.505, YearSummary.new(user: @user, year: 2024).average_saved_by_month
  end

  test '.saving_estimation returns the estimate' do
    assert_equal 3714.02, YearSummary.new(user: @user, year: 2024).saving_estimation
  end

  test '.saving_by_months returns the estimate' do
    expected = [
      { month: Time.zone.local(2024, 1, 1), amount: 0.0 },
      { month: Time.zone.local(2024, 2, 1), amount: 0.0 },
      { month: Time.zone.local(2024, 3, 1), amount: 654.04 },
      { month: Time.zone.local(2024, 4, 1), amount: 1202.97 }
    ]

    assert_equal expected, YearSummary.new(user: @user, year: 2024).saving_by_months
  end
end
