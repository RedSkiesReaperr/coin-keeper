# frozen_string_literal: true

require 'rails_helper'

describe MovementBuilder do
  let(:builder) { described_class.new }

  describe '.build_date' do
    it 'sets the date' do
      builder.build_date('10/10/2024')
      expect(builder.movement.date).to eq(Date.new(2024, 10, 10))
    end
  end

  describe '.build_label' do
    it 'sets the label' do
      builder.build_label('label #1')
      expect(builder.movement.label).to eq('label #1')
    end
  end

  describe '.build_supplier' do
    context 'when supplier argument is nil' do
      it 'sets the supplier as "Unknown"' do
        builder.build_supplier(nil)
        expect(builder.movement.supplier).to eq('Unknown')
      end
    end

    context 'when supplier argument is not nil' do
      it 'sets the supplier with argument value' do
        builder.build_supplier('supplier #1')
        expect(builder.movement.supplier).to eq('supplier #1')
      end
    end
  end

  describe '.build_amount' do
    context 'with String argument' do
      it 'converts arguments & sets the amount' do
        builder.build_amount('-8,99')
        expect(builder.movement.amount).to eq(-8.99)
      end
    end

    context 'with numeric argument' do
      it 'sets the amount' do
        builder.build_amount(-12.99)
        expect(builder.movement.amount).to eq(-12.99)
      end
    end
  end

  describe '.build_comment' do
    it 'sets the comment' do
      builder.build_comment('comment #1')
      expect(builder.movement.comment).to eq('comment #1')
    end
  end

  describe '.build_pointed' do
    it 'sets the pointed' do
      builder.build_pointed(true)
      expect(builder.movement.pointed).to be(true)
    end
  end

  describe '.build_ignored' do
    it 'sets the ignored' do
      builder.build_ignored(true)
      expect(builder.movement.ignored).to be(true)
    end
  end

  describe '.build_user' do
    let(:user) { create(:user) }

    it 'sets the user' do
      builder.build_user(user)
      expect(builder.movement.user).to eq(user)
    end
  end
end
