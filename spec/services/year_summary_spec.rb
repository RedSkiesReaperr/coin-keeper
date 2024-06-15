# frozen_string_literal: true

require 'rails_helper'

describe YearSummary do
  let(:user) { create(:user) }
  let(:service) { described_class.new(movements: Movement.all, year: 2024) }

  before do
    travel_to(Date.new(2024, 5, 15))

    # January
    create(:movement, user:, date: Date.new(2024, 1, 10), amount: -931.07, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 22), amount: -25.43, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 24), amount: 488.95, ignored: false)
    # February
    create(:movement, user:, date: Date.new(2024, 2, 1), amount: -707.38, ignored: false)
    create(:movement, user:, date: Date.new(2024, 2, 3), amount: -609.83, ignored: false)
    create(:movement, user:, date: Date.new(2024, 2, 4), amount: 762.05, ignored: false)
    create(:movement, user:, date: Date.new(2024, 2, 5), amount: 188.49, ignored: false)
    # March
    create(:movement, user:, date: Date.new(2024, 3, 8), amount: -965.43, ignored: false)
    create(:movement, user:, date: Date.new(2024, 3, 18), amount: 840.39, ignored: false)
    create(:movement, user:, date: Date.new(2024, 3, 20), amount: 779.08, ignored: false)
    # April
    create(:movement, user:, date: Date.new(2024, 4, 6), amount: 598.26, ignored: false)
    create(:movement, user:, date: Date.new(2024, 4, 16), amount: 902.43, ignored: false)
    create(:movement, user:, date: Date.new(2024, 4, 23), amount: -297.72, ignored: false)
  end

  describe '.saved_amount' do
    it 'returns overall saved amount' do
      expect(service.saved_amount).to eq(1022.79)
    end
  end

  describe '.average_saved_by_month' do
    it 'returns average value' do
      expect(service.average_saved_by_month).to eq(928.505)
    end
  end

  describe '.saving_estimation' do
    it 'returns year saving estimation' do
      expect(service.saving_estimation).to eq(2_599.814)
    end
  end

  describe '.saving_by_months' do
    let(:expected) do
      [
        { month: Time.zone.local(2024, 1, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 2, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 3, 1), amount: 654.04 },
        { month: Time.zone.local(2024, 4, 1), amount: 1202.97 },
        { month: Time.zone.local(2024, 5, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 6, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 7, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 8, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 9, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 10, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 11, 1), amount: 0.0 },
        { month: Time.zone.local(2024, 12, 1), amount: 0.0 }
      ]
    end

    it 'returns the estimate' do
      expect(service.saving_by_months).to eq(expected)
    end
  end
end
