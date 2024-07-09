# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPreference do
  describe 'validations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }

    describe '.start_date' do
      let(:user_preference) { build(:user_preference, start_date:, end_date:) }

      context 'when start_date is after end_date' do # rubocop:disable RSpec/NestedGroups
        let(:start_date) { Time.zone.tomorrow }
        let(:end_date) { Time.zone.today }

        it { expect(user_preference.valid?).to be(false) }
      end

      context 'when start_date is before end_date' do # rubocop:disable RSpec/NestedGroups
        let(:start_date) { Time.zone.today }
        let(:end_date) { Time.zone.tomorrow }

        it { expect(user_preference.valid?).to be(true) }
      end
    end

    describe '.end_date' do
      let(:user_preference) { build(:user_preference, start_date:, end_date:) }

      context 'when end_date is after start_date' do # rubocop:disable RSpec/NestedGroups
        let(:start_date) { Time.zone.today }
        let(:end_date) { Time.zone.tomorrow }

        it { expect(user_preference.valid?).to be(true) }
      end

      context 'when end_date is before start_date' do # rubocop:disable RSpec/NestedGroups
        let(:start_date) { Time.zone.tomorrow }
        let(:end_date) { Time.zone.today }

        it { expect(user_preference.valid?).to be(false) }
      end
    end
  end
end
