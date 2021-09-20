require 'rails_helper'

RSpec.describe 'ShowGameRooms', type: :system do
  include_context 'when user is logged in'
  let(:user) { build(:user) }
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
  end
end
