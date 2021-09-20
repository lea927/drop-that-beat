require 'rails_helper'

RSpec.describe 'ShowGameRooms', type: :system do
  include_context 'when user is logged in'
  let(:user) { build(:user) }
  let(:room) { create(:room) }

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
  end
end
