# frozen_string_literal: true

module MovementsHelper
  def date(movement)
    movement.date.strftime('%d/%m/%Y')
  end

  def amount(movement)
    number_to_currency(movement.amount, unit: '€', format: '%n %u')
  end
end
