require 'rails_helper'

RSpec.describe 'ShowGameRooms', type: :system do
  include_context 'when user is logged in'
  let(:track) { create(:track) }
  let!(:room) { create(:room, tracks: [track]) }

  before do
    driven_by(:rack_test)
    visit rooms_path
  end

  context 'when is user logged in and joins a room' do
    it 'is on the correct path' do
      expect(page).to have_current_path(rooms_path)
    end

    it 'visits all rooms page' do
      expect(page).to have_content 'All Music Rooms'
    end

    it 'searches a room to join' do
      fill_in 'search',	with: track.artist
      click_on 'Search'
      click_on room.name
    end

    it 'tells user if the room url is invalid' do
      visit room_path(room.id + 1)
      expect(page).to have_content 'Room doesn\'t exist.'
    end
  end

  context 'when user is logged in and joins a room without tracks' do
    it 'does not display rooms without tracks' do
      RoomTrack.find_by(room_id: room.id).destroy
      visit rooms_path
      expect(page).not_to have_content room.name
    end
  end
end
