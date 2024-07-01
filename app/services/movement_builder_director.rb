# frozen_string_literal: true

class MovementBuilderDirector
  def initialize(user)
    @user = user
    @builder = MovementBuilder.new
  end

  def build_from_csv(raw_data)
    csv_data_struct = csv_struct(raw_data)
    build(csv_data_struct)

    @builder.movement
  end

  private

  def build(struct)
    @builder.build_date(struct.date)
    @builder.build_label(struct.label)
    @builder.build_supplier(struct.supplier)
    @builder.build_amount(struct.amount)
    @builder.build_comment(nil)
    @builder.build_pointed(false)
    @builder.build_ignored(false)
    @builder.build_user(@user)
  end

  def data_struct
    Struct.new(:date, :label, :supplier, :amount)
  end

  def csv_struct(raw_data)
    data_struct.new(raw_data['dateOp'], raw_data['label'], raw_data['supplierFound'], raw_data['amount'])
  end
end
