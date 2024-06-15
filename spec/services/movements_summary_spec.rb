# frozen_string_literal: true

require 'rails_helper'

describe MovementsSummary do
  let(:user) { create(:user) }
  let(:period) { Date.new(2024, 1, 22)..Date.new(2024, 4, 16) }
  let(:service) { described_class.new(movements: Movement.all, period:) }

  before do
    # January
    create(:movement, user:, date: Date.new(2024, 1, 10), amount: -931.07, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 11), amount: -736.07, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 11), amount: -831.07, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 12), amount: -131.07, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 22), amount: -25.43, ignored: false)
    create(:movement, user:, date: Date.new(2024, 1, 22), amount: 488.95, ignored: false)
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

  describe '.total' do
    it 'returns sum of all period movements' do
      expect(service.total).to eq(2_251.58)
    end
  end

  describe '.by_days' do
    let(:period) { Date.new(2024, 1, 10)..Date.new(2024, 1, 13) }
    let(:expected) do
      [
        { day: Date.new(2024, 1, 10), amount: 931.07 },
        { day: Date.new(2024, 1, 11), amount: 1_567.14 },
        { day: Date.new(2024, 1, 12), amount: 131.07 },
        { day: Date.new(2024, 1, 13), amount: 0.0 }
      ]
    end

    it 'returns an array of days in period with their amounts' do
      expect(service.by_days).to eq(expected)
    end
  end
end
