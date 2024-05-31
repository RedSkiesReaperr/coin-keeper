# frozen_string_literal: true

module MovementsHelper
  def date(movement)
    movement.date.strftime('%d/%m/%Y')
  end

  def amount(movement)
    amount = number_to_currency(movement.amount, unit: '€', format: '%n %u')
    color = movement.amount.positive? ? 'text-green-600' : 'text-red-600'

    tag.p(amount, class: color)
  end
end
