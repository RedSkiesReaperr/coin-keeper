# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportMovementsJob do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }
  let(:csv_file) { Tempfile.new('import.csv') }
  let(:job) { described_class.perform_now(user:, attachment_id: @attachment_id) } # rubocop:disable RSpec/InstanceVariable

  before do
    csv_file.binmode
    csv_file.write(file_content)
    csv_file.rewind

    attachments = user.import_files.attach(io: csv_file, filename: 'import.csv', content_type: 'text/csv')
    @attachment_id = attachments.last.id
  end

  context 'when csv file is valid' do
    let(:file_content) do
      <<~CONTENT
        dateOp;label;supplierFound;amount
        21/06/2024;test1;suppl1;-12,76
        22/06/2024;test2;suppl2;-122,76
      CONTENT
    end

    it { expect { job }.not_to raise_error }

    it { expect { job }.to change(Movement, :count).by(2) }
  end
end
