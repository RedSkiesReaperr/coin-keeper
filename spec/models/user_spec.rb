# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to have_one :user_preference }

    it { is_expected.to have_many :movements }

    it { is_expected.to have_many_attached :import_files }
  end

  describe 'callbacks' do
    describe 'after_create' do
      it 'creates user preferences' do
        expect { create(:user) }.to change(UserPreference, :count).by(1)
      end
    end
  end
end
