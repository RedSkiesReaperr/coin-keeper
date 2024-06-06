# frozen_string_literal: true

require 'capybara/rspec'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = ENV['HEADLESS'] == 'true' ? :selenium_chrome_headless : :selenium_chrome

RSpec.configure do |config|
  config.after do |example|
    puts "\nScreenshot saved to => #{save_and_open_screenshot}\n\n" if example.exception # rubocop:disable Lint/Debugger
  end
end
