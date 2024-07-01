# frozen_string_literal: true

require 'rails_helper'
require 'csv'

describe MovementBuilderDirector do
  let(:user) { create(:user) }
  let(:director) { described_class.new(user) }

  describe '.build_from_csv' do
    let(:result) { director.build_from_csv(raw_csv) }
    let(:raw_csv) do
      CSV::Row.new(%w[dateOp label supplierFound amount], [
                     '01/07/2024',
                     'CARD 01/07/24 TEST CB*1234',
                     'TEST_SUPPL',
                     '-627,37'
                   ])
    end
    let(:expected_attributes) do
      {
        date: Date.new(2024, 7, 1),
        label: 'CARD 01/07/24 TEST CB*1234',
        supplier: 'TEST_SUPPL',
        amount: -627.37
      }
    end

    it 'returns a Movement object' do
      expect(result).to be_a(Movement)
    end

    it { expect(result).to have_attributes(expected_attributes) }
  end
end
