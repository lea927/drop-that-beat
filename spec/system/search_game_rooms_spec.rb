require 'rails_helper'

RSpec.describe 'SearchGameRooms', type: :system do
  let(:user) { build(:user, points: 100) }
  let(:track) { create(:track, artist: 'dua lipa') }
  let!(:room) { create(:room, tracks: [track]) }

  before do
    driven_by(:rack_test)
    user.skip_confirmation!
    user.save!
    sign_in user
    visit rooms_path
  end

  context 'when user is logged in and views all rooms' do
    it 'shows list of rooms created' do
      expect(page).to have_content(/#{room.name}/i)
    end

    it 'shows search bar' do
      expect(page).to have_field('search')
    end
  end

  context 'when user searches rooms with valid query' do
    it 'shows rooms with associated query' do
      fill_in 'search',	with: track.artist
      click_on 'Search'
      expect(page).to have_content(/#{room.name}/i)
    end
  end

  context 'when user searches rooms with invalid query' do
    it 'does not show rooms without associated query' do
      fill_in 'search',	with: 'Bruno Mars'
      click_on 'Search'
      expect(page).not_to have_content(/#{room.name}/i)
    end

    it 'displays error message' do
      fill_in 'search',	with: 'Bruno Mars'
      click_on 'Search'
      expect(page).to have_content('Cannot find rooms with associated artist')
    end
  end

  context 'when user searches with blank query' do
    it 'shows all rooms' do
      fill_in 'search',	with: ''
      click_on 'Search'
      expect(page).to have_content(/#{room.name}/i)
    end

    it 'displays error message' do
      click_on 'Search'
      expect(page).to have_content('Please enter an artist to search')
    end
  end
end
