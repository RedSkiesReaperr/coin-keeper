# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movement do
  describe 'validations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:supplier) }
    it { is_expected.to validate_presence_of(:amount) }

    describe '.date' do
      let(:past_movement) { build(:movement, date: Time.zone.yesterday) }
      let(:future_movement) { build(:movement, date: Time.zone.tomorrow) }

      it 'when date is in the past' do
        expect(past_movement.valid?).to be(true)
      end

      it 'when date is in the future' do
        expect(future_movement.valid?).to be(false)
      end
    end
  end

  describe '.pointed' do
    let(:pointed) { create_list(:movement, 1, pointed: true) }
    let(:not_pointed) { create_list(:movement, 2, pointed: false) }

    context 'with true as argument' do
      it 'returns only pointed movements' do
        expect(described_class.pointed(true)).to eq(pointed)
      end
    end

    context 'with false as argument' do
      it 'returns only not pointed movements' do
        expect(described_class.pointed(false)).to eq(not_pointed)
      end
    end
  end

  describe '.ignored' do
    let(:ignored) { create_list(:movement, 3, ignored: true) }
    let(:not_ignored) { create_list(:movement, 2, ignored: false) }

    context 'with true as argument' do
      it 'returns only ignored movements' do
        expect(described_class.ignored(true)).to eq(ignored)
      end
    end

    context 'with false as argument' do
      it 'returns only not ignored movements' do
        expect(described_class.ignored(false)).to eq(not_ignored)
      end
    end
  end

  describe '.within_date_range' do
    let(:range) { Time.zone.today..Time.zone.tomorrow }
    let(:in_date_range) { create_list(:movement, 3, date: Time.zone.today) }
    let(:not_in_date_range) { create_list(:movement, 2, date: Time.zone.yesterday) }

    it 'returns only movements with date in range' do
      expect(described_class.within_date_range(range)).to eq(in_date_range)
    end
  end

  describe '.incomes' do
    let(:incomes) { create_list(:movement, 2, amount: Faker::Number.positive) }
    let(:not_incomes) { create_list(:movement, 3, amount: Faker::Number.negative) }

    it 'returns only movements with positive amount' do
      expect(described_class.incomes).to eq(incomes)
    end
  end

  describe '.expenses' do
    let(:expenses) { create_list(:movement, 2, amount: Faker::Number.negative) }
    let(:not_expenses) { create_list(:movement, 3, amount: Faker::Number.positive) }

    it 'returns only movements with negative amount' do
      expect(described_class.expenses).to eq(expenses)
    end
  end

  describe '.search' do
    let(:movements) do
      [
        create(:movement, label: 'Kandinsky', supplier: 'Winslow Homer', comment: 'Red Pub'),
        create(:movement, label: 'Donatello', supplier: 'Magritte', comment: 'Smokestack BBQ'),
        create(:movement, label: 'Cezanne', supplier: 'Vincent', comment: 'Green Steakhouse'),
        create(:movement, label: 'Donatello', supplier: 'Caravaggio', comment: 'Blue King'),
        create(:movement, label: 'Warhol', supplier: 'Kahlo', comment: 'Big Coffee'),
        create(:movement, label: 'Manet', supplier: 'Degas', comment: '12 Box')
      ]
    end

    context 'when searching for a label' do
      it 'returns only movements with label' do
        expect(described_class.search('Donatello')).to eq([movements[1], movements[3]])
      end
    end

    context 'when searching for a supplier' do
      it 'returns only movements with supplier' do
        expect(described_class.search('Vincent')).to eq([movements[2]])
      end
    end

    context 'when searching for a comment' do
      it 'returns only movements with comment' do
        expect(described_class.search('Big Coffee')).to eq([movements[4]])
      end
    end

    context 'when searching with non existent movement' do
      it { expect(described_class.search('Not found')).to be_empty }
    end
  end
end
