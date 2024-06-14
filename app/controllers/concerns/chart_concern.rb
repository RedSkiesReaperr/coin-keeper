# frozen_string_literal: true

module ChartConcern
  extend ActiveSupport::Concern

  protected

  def build_series(data, key:, value:)
    series = data.map { |serie| { key: serie[key], value: serie[value] } }

    [series]
  end
end
