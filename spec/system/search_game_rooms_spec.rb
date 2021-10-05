require 'rails_helper'

RSpec.describe 'SearchGameRooms', type: :system do
  include_context 'when user is logged in'
  let(:user2) { create(:user, username: 'janedoe', email: 'janedoe@example.com') }
  let(:track) { create(:track, artist: 'unordinary sunday, kino & yumin', name: 'UNORDINARY SUNDAY, Vol. 2 - Sunflower', adam_id: '1568415083', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/67/4c/d7/674cd77b-8931-34a4-1148-7febd8ce042f/mzaf_13159739854727306776.plus.aac.p.m4a') }
  let!(:invalid_room) { create(:room, name: 'BTS', users: [user]) }
  let!(:valid_room) do
    user2.confirm
    create(:room, users: [user2])
  end

  before do
    driven_by(:rack_test)
    valid_room.tracks.push(track)
    visit rooms_path
  end

  context 'when user is logged in and views all rooms' do
    it 'shows list of playable rooms' do
      expect(page).to have_content(/#{valid_room.name}/i).once
    end

    it 'does not display rooms created' do
      expect(page).not_to have_content(invalid_room.name)
    end

    it 'shows search bar' do
      expect(page).to have_field('search')
    end
  end

  context 'when user searches rooms with valid query' do
    it 'shows rooms with associated query' do
      fill_in 'search',	with: track.artist
      click_on 'Search'
      expect(page).to have_content(/#{valid_room.name}/i).once
    end
  end

  context 'when user searches rooms with invalid query' do
    it 'does not show rooms without associated query' do
      fill_in 'search',	with: 'Bruno Mars'
      click_on 'Search'
      expect(page).not_to have_content(/#{valid_room.name}/i)
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
      expect(page).to have_content(/#{valid_room.name}/i)
    end

    it 'displays error message' do
      click_on 'Search'
      expect(page).to have_content('Please enter an artist to search')
    end
  end

  context 'when user searches rooms with a featuring artist' do
    it 'shows rooms with associated artist' do
      fill_in 'search',	with: 'kino'
      click_on 'Search'
      expect(page).to have_content(/#{valid_room.name}/i).once
    end
  end
end
