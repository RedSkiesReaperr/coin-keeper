# frozen_string_literal: true

require 'csv'

module CsvReader
  module_function

  def read(file_path:, separator: ';')
    file = File.read(file_path, encoding: 'bom|utf-8')

    CSV.parse(file, headers: true, col_sep: separator)
  end
end
