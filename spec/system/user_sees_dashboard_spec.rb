# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sees dashboard', :js do
  let(:user) { create(:user) }
  let(:movements) do
    [
      # December, 2023
      create(:movement, user:, date: Date.new(2023, 12, 16), amount: -9.07, ignored: false),
      create(:movement, user:, date: Date.new(2023, 12, 21), amount: 93.21, ignored: false),
      # January
      create(:movement, user:, date: Date.new(2024, 1, 10), amount: -931.07, ignored: false),
      create(:movement, user:, date: Date.new(2024, 1, 22), amount: -25.43, ignored: false),
      create(:movement, user:, date: Date.new(2024, 1, 24), amount: 488.95, ignored: false),
      # February
      create(:movement, user:, date: Date.new(2024, 2, 1), amount: -707.38, ignored: false),
      create(:movement, user:, date: Date.new(2024, 2, 3), amount: -609.83, ignored: false),
      create(:movement, user:, date: Date.new(2024, 2, 4), amount: 762.05, ignored: false),
      create(:movement, user:, date: Date.new(2024, 2, 5), amount: 188.49, ignored: false),
      # March
      create(:movement, user:, date: Date.new(2024, 3, 8), amount: -965.43, ignored: false),
      create(:movement, user:, date: Date.new(2024, 3, 18), amount: 840.39, ignored: false),
      create(:movement, user:, date: Date.new(2024, 3, 20), amount: 779.08, ignored: false),
      # April
      create(:movement, user:, date: Date.new(2024, 4, 6), amount: 598.26, ignored: false),
      create(:movement, user:, date: Date.new(2024, 4, 16), amount: 902.43, ignored: false),
      create(:movement, user:, date: Date.new(2024, 4, 23), amount: -297.72, ignored: false),
      # June
      create(:movement, user:, date: Date.new(2024, 6, 2), amount: 234.29, ignored: false),
      create(:movement, user:, date: Date.new(2024, 6, 6), amount: 710.33, ignored: false),
      create(:movement, user:, date: Date.new(2024, 6, 10), amount: -263.73, ignored: false)
    ]
  end

  before do
    travel_to(Date.new(2024, 7, 1))

    movements
    sign_in user
    visit dashboard_path
  end

  # FIXME: When `to categorize` counter becomes dynamic
  it 'sees movements to categorize counter' do
    expect(page).to have_content('333 Movements to categorize', normalize_ws: true)
  end

  it 'sees earnings total' do
    expect(page).to have_content('1,439.49 € Earnings', normalize_ws: true)
  end

  it 'sees expenses total' do
    expect(page).to have_content('-2,273.71 € Expenses', normalize_ws: true)
  end

  it 'sees how much saved this year' do
    expect(page).to have_content('1,703.68 € Saved this year', normalize_ws: true)
  end

  it 'sees average saved per month' do
    expect(page).to have_content('845.97 € Average saved per month', normalize_ws: true)
  end

  it 'sees saving estimation at the end of year' do
    expect(page).to have_content('1,812.79 € Estimated saving at the end of year', normalize_ws: true)
  end
end
