# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPreference do
  describe 'validations' do
    it { is_expected.to belong_to :user }
  end
end
