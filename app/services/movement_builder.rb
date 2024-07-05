# frozen_string_literal: true

class MovementBuilder
  attr_reader :movement

  def initialize
    @movement = Movement.new
  end

  def build_date(date)
    @movement.date = date
  end

  def build_label(label)
    @movement.label = label
  end

  def build_supplier(supplier)
    @movement.supplier = (supplier.presence || 'Unknown')
  end

  def build_amount(amount)
    @movement.amount = if amount.is_a?(String)
                         amount_from_string(amount)
                       else
                         amount
                       end
  end

  def build_comment(comment)
    @movement.comment = comment
  end

  def build_pointed(pointed)
    @movement.pointed = pointed
  end

  def build_ignored(ignored)
    @movement.ignored = ignored
  end

  def build_user(user)
    @movement.user = user
  end

  private

  def amount_from_string(str)
    str.delete(' ').gsub(',', '.').to_f
  end
end
