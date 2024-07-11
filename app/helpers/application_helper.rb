# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flashes', partial: 'layouts/flashes'
  end

  def flash_icon(type)
    types_icons = {
      alert: 'exclamation-circle',
      notice: 'check-circle',
      info: 'information-circle',
      warn: 'exclamation-triangle'
    }

    heroicon types_icons[type.to_sym], variant: 'outline'
  end

  def currency(number, options = {})
    number_to_currency(number, unit: '€', format: '%n %u', **options)
  end
end
