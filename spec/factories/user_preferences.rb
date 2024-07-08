# frozen_string_literal: true

FactoryBot.define do
  factory :user_preference do
    user
    start_date { Faker::Date.between(from: 1.week.ago, to: Time.zone.today) }
    end_date { Faker::Date.between(from: Time.zone.tomorrow, to: 1.week.after(Time.zone.tomorrow)) }
  end
end
