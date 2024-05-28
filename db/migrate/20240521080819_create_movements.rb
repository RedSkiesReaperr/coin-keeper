# frozen_string_literal: true

class CreateMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :movements do |t|
      t.date :date, null: false
      t.string :label, null: false
      t.string :supplier, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.text :comment
      t.boolean :pointed, null: false, default: false
      t.boolean :ignored, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
