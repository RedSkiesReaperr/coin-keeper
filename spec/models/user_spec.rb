# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to have_many :movements }

    it { is_expected.to have_many_attached :import_files }
  end
end
