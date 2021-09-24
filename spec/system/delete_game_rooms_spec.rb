require 'rails_helper'

RSpec.describe 'DeleteGameRooms', type: :system do
  include_context 'when user is logged in'

  let(:user) { build(:user, points: 100, rooms: [room]) }
  let(:room) { create(:room) }

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path
  end

  context 'when deleting a room' do
    before do
      click_on 'Delete'
      page.driver.browser.switch_to.alert.accept
    end

    it 'displays success message' do
      expect(page).to have_content('Room was successfully deleted')
    end

    it 'removes game room from home page' do
      expect(page).not_to have_content(room.name)
    end
  end
end
