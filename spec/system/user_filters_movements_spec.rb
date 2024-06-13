# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User updates movement', :js do
  let(:search_as_you_type_delay) { 0.750 } # In seconds
  let(:user) { create(:user) }
  let!(:movements) do
    [
      create(:movement, user:, label: 'Movement #1', amount: 12.83, comment: 'comment #1', supplier: 'supplier #1',
                        pointed: true, ignored: false),
      create(:movement, user:, label: 'Movement #2', amount: -711.83, comment: 'comment #2', supplier: 'supplier #2',
                        pointed: true, ignored: false),
      create(:movement, user:, label: 'Movement #3', amount: 9.83, comment: 'comment #3', supplier: 'supplier #3',
                        pointed: false, ignored: true)
    ]
  end

  before do
    sign_in user
    visit movements_path
  end

  context 'when no filters applied' do
    it 'displays all movements' do
      movements.each do |movement|
        expect(page).to have_content(movement.label)
      end
    end
  end

  context 'when filtering by label' do
    before do
      fill_in 'query', with: 'Movement #1'
      sleep search_as_you_type_delay
    end

    it 'displays matching movements' do
      expect(page).to have_content('Movement #1')
    end

    it 'does not display not matching movements' do
      ['Movement #2', 'Movement #3'].each do |movement|
        expect(page).to have_no_content(movement)
      end
    end
  end

  context 'when filtering by comment' do
    before do
      fill_in 'query', with: 'comment #2'
      sleep search_as_you_type_delay
    end

    it 'displays matching movements' do
      expect(page).to have_content('Movement #2')
    end

    it 'does not display not matching movements' do
      ['Movement #1', 'Movement #3'].each do |movement|
        expect(page).to have_no_content(movement)
      end
    end
  end

  context 'when filtering by supplier' do
    before do
      fill_in 'query', with: 'supplier #2'
      sleep search_as_you_type_delay
    end

    it 'displays matching movements' do
      expect(page).to have_content('Movement #2')
    end

    it 'does not display not matching movements' do
      ['Movement #1', 'Movement #3'].each do |movement|
        expect(page).to have_no_content(movement)
      end
    end
  end

  context 'when filtering by amount' do
    before do
      fill_in 'query', with: 9.83
      sleep search_as_you_type_delay
    end

    it 'displays matching movements' do
      expect(page).to have_content('Movement #3')
    end

    it 'does not display not matching movements' do
      ['Movement #1', 'Movement #2'].each do |movement|
        expect(page).to have_no_content(movement)
      end
    end
  end

  context 'when filtering by `pointed` status' do
    before do
      select 'Pointed', from: 'pointed'
    end

    it 'displays pointed movements' do
      ['Movement #1', 'Movement #2'].each do |movement|
        expect(page).to have_content(movement)
      end
    end

    it 'does not display not pointed movements' do
      expect(page).to have_no_content('Movement #3')
    end
  end

  context 'when filtering by `ignored` status' do
    before do
      select 'Ignored', from: 'ignored'
    end

    it 'displays ignored movements' do
      expect(page).to have_content('Movement #3')
    end

    it 'does not display not ignored movements' do
      ['Movement #1', 'Movement #2'].each do |movement|
        expect(page).to have_no_content(movement)
      end
    end
  end

  context 'when clearing filters' do
    before do
      fill_in 'query', with: 'Movement #1'
      select 'Pointed', from: 'pointed'
      select 'Not ignored', from: 'ignored'
      sleep search_as_you_type_delay
      click_on 'clear'
    end

    it 'resets query filter' do
      expect(page).to have_field('query', with: nil)
    end

    it "resets 'pointed' filter" do
      expect(page).to have_select('pointed', selected: "All 'pointed' status")
    end

    it "resets 'ignored' filter" do
      expect(page).to have_select('ignored', selected: "All 'ignored' status")
    end

    it 'displays all movements' do
      movements.each do |movement|
        expect(page).to have_content(movement.label)
      end
    end
  end
end
