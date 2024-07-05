# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User imports movements', :js do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }
  let(:csv_file) { Tempfile.new('import.csv') }
  let(:file_content) do
    <<~CONTENT
      dateOp;label;supplierFound;amount
      21/06/2024;test1;suppl1;-12,76
      22/06/2024;test2;suppl2;-122,76
    CONTENT
  end

  before do
    csv_file.binmode
    csv_file.write(file_content)
    csv_file.rewind

    sign_in user
    visit movements_path
  end

  context 'when importing csv file' do
    before do
      attach_file('file', csv_file.path, make_visible: true)
      sleep 1
      perform_enqueued_jobs
    end

    it 'notifies importing process task is created' do
      expect(page).to have_content('Movements import task created')
    end

    it 'notifies importing process has started' do
      expect(page).to have_content('Movements import started, please wait...')
    end

    it 'notifies importing process has succeed' do
      expect(page).to have_content('Movements were successfully imported')
    end

    it 'displays correct movements count' do
      visit current_path
      expect(page).to have_content('2 Movements', normalize_ws: true)
    end

    it 'displays correct total amount' do
      visit current_path
      expect(page).to have_content('-135.52 € Total amount', normalize_ws: true)
    end
  end
end
