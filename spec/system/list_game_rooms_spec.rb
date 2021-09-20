require 'rails_helper'

RSpec.describe 'ListGameRooms', type: :system do
  include_context 'when user is logged in'

  let(:user) { build(:user, points: 100, rooms: [room]) }
  let(:room) { create(:room) }

  before do
    driven_by(:rack_test)
    visit root_path
  end

  context 'when user is logged in and created a room' do
    it 'shows list of rooms created' do
      expect(page).to have_content(room.name)
    end

    it 'shows user points' do
      expect(page).to have_content(user.points)
    end

    it 'shows create game link' do
      expect(page).to have_link('CREATE A ROOM', href: new_room_path)
    end

    it 'redirects to new game room when game button is clicked' do
      find_link('CREATE A ROOM').click
      expect(page).to have_current_path(new_room_path)
    end

    it 'redirects to edit game room when room is clicked' do
      find_link(room.name).click
      expect(page).to have_current_path(edit_room_path(room))
    end
  end

  context 'when user is not logged in' do
    it 'does not show rooms created' do
      sign_out user
      visit root_path
      expect(page).not_to have_content(room.name)
    end
  end
end
