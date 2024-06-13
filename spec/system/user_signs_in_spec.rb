# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs in', :js do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    click_on 'Sign in'
  end

  context 'with invalid credentials' do
    let(:email) { 'Invalidemail@gmail.com' }
    let(:password) { 'invalidPassword' }

    it 'stays to the sign in page' do
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'displays error' do
      expect(page).to have_text('Invalid Email or password.')
    end
  end

  context 'with valid credentials' do
    let(:email) { user.email }
    let(:password) { user.password }

    it 'redirects to the dashboard page' do
      expect(page).to have_current_path(dashboard_path)
    end
  end
end
