# frozen_string_literal: true

# rubocop:disable Rails/Output

puts '===== Seeding database ====='

NUMBER_OF_MOVEMENTS = Faker::Number.within(range: 1000..10_000)

user = User.create!(email: 'test@gmail.com', password: 'password')
user2 = User.create!(email: 'foo.bar@foobar.com', password: 'password')
puts '✓ Users created'

NUMBER_OF_MOVEMENTS.times do
  date = Faker::Date.between(from: 6.months.ago, to: 1.day.ago)
  label = "#{Faker::Invoice.reference} #{Faker::Company.name}"
  supplier = Faker::Company.name
  amount = Faker::Number.within(range: -500.0..500.0)
  comment = Faker::Boolean.boolean ? Faker::ChuckNorris.fact : nil
  pointed = Faker::Boolean.boolean
  ignored = Faker::Boolean.boolean
  target_user = Faker::Boolean.boolean ? user : user2

  Movement.create!(date:, label:, supplier:, amount:, comment:, pointed:, ignored:, user: target_user)
end
puts "✓ #{NUMBER_OF_MOVEMENTS} movements created"
# rubocop:enable Rails/Output
