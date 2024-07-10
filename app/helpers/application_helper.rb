# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end

  def currency(number, options = {})
    number_to_currency(number, unit: '€', format: '%n %u', **options)
  end
end
