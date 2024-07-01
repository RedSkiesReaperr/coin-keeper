# frozen_string_literal: true

require 'rails_helper'

describe CsvReader do
  describe '.read' do
    let(:tmp_file) { Tempfile.new('file.csv') }

    before do
      tmp_file.write("header1;header2;header3;\nvalue1;value2;value3;\nvalue4;value5;value6")
      tmp_file.close
    end

    after do
      tmp_file.unlink
    end

    it 'returns CSV::Table object' do
      expect(described_class.read(file_path: tmp_file.path)).to be_a(CSV::Table)
    end
  end
end
