# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def flash_classes(type)
    flash_colors = { 'alert' => 'red', 'notice' => 'green', 'info' => 'blue', 'warn' => 'yellow', 'default' => 'gray' }
    color = flash_colors[type] || flash_colors['default']

    "text-#{color}-800 bg-#{color}-50 border-#{color}-300 dark:text-#{color}-400 dark:border-#{color}-800"
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end

  def currency(number, options = {})
    number_to_currency(number, unit: '€', format: '%n %u', **options)
  end
end
