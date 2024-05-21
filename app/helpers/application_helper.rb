# frozen_string_literal: true

module ApplicationHelper
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
end
