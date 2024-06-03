# frozen_string_literal: true

FactoryBot.define do
  factory :movement do
    date { Time.zone.today }
    label { Faker::Company.catch_phrase }
    supplier { Faker::Company.name }
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    comment { Faker::ChuckNorris.fact }
    pointed { Faker::Boolean.boolean }
    ignored { Faker::Boolean.boolean }
    user
  end
end
