require 'rails_helper'

RSpec.describe 'ShowGameRooms', type: :system do
  include_context 'when user is logged in'
  let(:user) { build(:user, points: 100, rooms: [room]) }
  let!(:room) { create(:room) }
  let(:track) { room.tracks.first }

  before do
    driven_by(:selenium_chrome_headless)
    visit rooms_path
  end

  context 'when is user logged in and joins a room' do
    it 'is on the correct path' do
      expect(page).to have_current_path(rooms_path)
    end

    it 'visits all rooms page' do
      expect(page).to have_content 'All Game Rooms'
    end

    it 'searches a room to join' do
      fill_in 'search',	with: track.artist
      page.find('#search-artist').click
      click_on room.name
    end

    it 'tells user if the room url is invalid' do
      visit room_path(room.id + 1)
      expect(page).to have_content 'Room doesn\'t exist.'
    end
  end

  context 'when user is logged in and joins a room without tracks' do
    it 'does not display rooms without tracks' do
      RoomTrack.where(room_id: room.id).destroy_all
      visit rooms_path
      expect(page).not_to have_content room.name
    end
  end
end
