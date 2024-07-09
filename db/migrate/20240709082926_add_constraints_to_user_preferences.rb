# frozen_string_literal: true

class AddConstraintsToUserPreferences < ActiveRecord::Migration[7.1]
  def up
    UserPreference.where('start_date IS NULL OR end_date IS NULL').each do |user_preference|
      user_preference.update!(start_date: Time.zone.today.beginning_of_month, end_date: Time.zone.today.end_of_month)
    end

    change_column :user_preferences, :start_date, :date, null: false
    change_column :user_preferences, :end_date, :date, null: false
  end

  def down
    change_column :user_preferences, :start_date, :date, null: true
    change_column :user_preferences, :end_date, :date, null: true
  end
end
