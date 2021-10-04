require 'rails_helper'

RSpec.describe 'StartGame', type: :system do
  include_context 'when user is logged in'
  let!(:room) { create(:room) }

  before do
    driven_by(:selenium_chrome_headless)
    visit room_path(room.id)
  end

  context 'when user visits a game room' do
    it 'shows start game button' do
      expect(page).to have_selector(:link_or_button, 'Start Game')
    end
  end

  context 'when user starts the game' do
    it 'does not show start game button' do
      click_on 'Start Game'
      expect(page).not_to have_selector(:link_or_button, 'Start Game')
    end

    it 'displays possible answers as buttons' do
      click_on 'Start Game'
      expect(page).to have_selector('.choiceBtn').exactly(3).times
    end
  end
end
