require 'rails_helper'

RSpec.describe 'EditGameRooms', type: :system do
  include_context 'when user creates a game room'
  let!(:room) { create(:room, users: [user]) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path
    click_on room.name
  end

  context 'with valid attributes' do
    before do
      update_room_name('animal2')
      update_rounds(2)
    end

    it 'saves correct data' do
      expect(room).to have_attributes(rounds: 2, name: 'animal2')
    end

    it 'generates success message' do
      expect(page).to have_content 'Game was updated successfully'
    end
  end
end
