# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User updates movement', :js do
  let(:user) { create(:user) }
  let(:movement) { create(:movement, user:, pointed: true, ignored: false) }

  before do
    sign_in user
    visit edit_movement_path(movement)
  end

  context 'when editing `label` field' do
    before do
      fill_in 'movement[label]', with: new_label
      click_on 'Save'
    end

    context 'with invalid value' do
      let(:new_label) { ' ' }

      it 'displays error message' do
        expect(page).to have_content('Label can\'t be blank')
      end
    end

    context 'with valid value' do
      let(:new_label) { 'My new Label' }

      it 'displays success message' do
        expect(page).to have_content(I18n.t('movements.update.success'))
      end

      it 'updated the label' do
        expect(page).to have_content(new_label)
      end
    end
  end

  context 'when editing `comment` field' do
    before do
      fill_in 'movement[comment]', with: new_comment
      click_on 'Save'
    end

    context 'with valid value' do
      let(:new_comment) { 'My updated comment!' }

      it 'displays success message' do
        expect(page).to have_content(I18n.t('movements.update.success'))
      end

      it 'updated the comment' do
        expect(page).to have_content(new_comment)
      end
    end
  end

  context 'when editing `pointed` field' do
    before do
      uncheck 'movement[pointed]'
      click_on 'Save'
    end

    it 'displays success message' do
      expect(page).to have_content(I18n.t('movements.update.success'))
    end

    it 'updated the pointed value' do
      expect(page).to have_field("movement_#{movement.id}[pointed]", checked: false, disabled: true)
    end
  end

  context 'when editing `ignored` field' do
    before do
      check 'movement[ignored]'
      click_on 'Save'
    end

    it 'displays success message' do
      expect(page).to have_content(I18n.t('movements.update.success'))
    end

    it 'updated the ignored value' do
      expect(page).to have_field("movement_#{movement.id}[ignored]", checked: true, disabled: true)
    end
  end
end
