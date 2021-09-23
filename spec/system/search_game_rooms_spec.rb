require 'rails_helper'

RSpec.describe 'SearchGameRooms', type: :system do
  include_context 'when user is logged in'
  let(:track) { create(:track) }
  let(:track2) { create(:track, name: 'idgaf', adam_id: '1228739604', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/dd/7c/f8/dd7cf8bf-61f2-45e3-9a52-63b7734d5ef1/mzaf_1015632960633637742.plus.aac.p.m4a') }
  let(:track3) { create(:track, artist: 'unordinary sunday, kino & yumin', name: 'UNORDINARY SUNDAY, Vol. 2 - Sunflower', adam_id: '1568415083', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/67/4c/d7/674cd77b-8931-34a4-1148-7febd8ce042f/mzaf_13159739854727306776.plus.aac.p.m4a') }
  let!(:room) { create(:room, tracks: [track, track2, track3]) }

  before do
    driven_by(:rack_test)
    visit rooms_path
  end

  context 'when user is logged in and views all rooms' do
    it 'shows list of rooms created' do
      expect(page).to have_content(/#{room.name}/i).once
    end

    it 'shows search bar' do
      expect(page).to have_field('search')
    end
  end

  context 'when user searches rooms with valid query' do
    it 'shows rooms with associated query' do
      fill_in 'search',	with: track.artist
      click_on 'Search'
      expect(page).to have_content(/#{room.name}/i).once
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

  context 'when user searches rooms with a featuring artist' do
    it 'shows rooms with associated artist' do
      fill_in 'search',	with: 'kino'
      click_on 'Search'
      expect(page).to have_content(/#{room.name}/i).once
    end
  end
end
