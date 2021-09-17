require 'rails_helper'

RSpec.describe 'SearchGameRooms', type: :system do
  let(:user) { build(:user, points: 100) }
  let(:track) { create(:track) }
  let(:room) { create(:room) }

  before do
    driven_by(:rack_test)
    user.skip_confirmation!
    user.save!
    sign_in user
    room
    track
    room.tracks << track
    visit rooms_path
  end

  context 'when user is logged in and views all rooms' do
    it 'shows list of rooms created' do
      expect(page).to have_content(room.name)
    end

    it 'shows search bar' do
      expect(page).to have_field('search')
    end
  end

  context 'when user searches rooms with valid query' do
    it 'shows rooms with associated query' do
      fill_in 'search',	with: track.artist
      click_on 'Search'
      expect(page).to have_content(room.name)
    end
  end

  context 'when user searches rooms with invalid query' do
    it 'does not show rooms without associated query' do
      fill_in 'search',	with: 'Bruno Mars'
      click_on 'Search'
      expect(page).not_to have_content(room.name)
    end

    it 'displays error message' do
      expect(page).not_to have_content('Cannot find rooms with associated artist')
    end
  end

  context 'when user searches with blank query' do
    it 'shows all rooms' do
      fill_in 'search',	with: ''
      click_on 'Search'
      expect(page).to have_content(room.name)
    end

    it 'displays error message' do
      expect(page).not_to have_content('Please enter an artist to to search')
    end
  end
end
