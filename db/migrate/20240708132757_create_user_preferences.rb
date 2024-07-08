# frozen_string_literal: true

class CreateUserPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    User.all.each { |u| UserPreference.create!(user: u) }
  end
end
