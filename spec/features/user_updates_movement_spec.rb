require 'rails_helper'

feature 'User updates movement', :js do
  let(:user) { create(:user) }
  let(:movement) { create(:movement, user:) }

  before do
    sign_in user
  end

  scenario 'they see the updated movement' do
    visit edit_movement_path(movement)

    fill_in 'movement[comment]', with: 'My updated comment!'
    click_on 'Update'

    expect(page).to have_content('My updated comment!')
  end
end
