# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_classes(type)
    case type
    when 'alert'
      'text-red-800 bg-red-50 border-red-300 dark:text-red-400 dark:border-red-800'
    when 'notice'
      'text-green-800 bg-green-50 border-green-300 dark:text-green-400 dark:border-green-800'
    else
      'text-gray-800 bg-gray-50 border-gray-300 dark:text-gray-300 dark:border-gray-800'
    end
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end

  def currency(number, options = {})
    number_to_currency(number, unit: '€', format: '%n %u', **options)
  end
end
