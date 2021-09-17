require 'rails_helper'

RSpec.describe 'SearchGameRooms', type: :system do
  let(:user) { build(:user, points: 100) }
  let(:room) { create(:room) }

  before do
    driven_by(:rack_test)
    user.skip_confirmation!
    user.save!
    sign_in user
    room
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
end
