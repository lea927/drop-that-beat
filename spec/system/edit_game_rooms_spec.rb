require 'rails_helper'

RSpec.describe 'EditGameRooms', type: :system do
  include_context 'when user creates a game room'

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path
    submit_form('animal')
  end

  context 'with valid attributes' do
    before { update_rounds(2) }

    it 'saves correct data' do
      expect(room).to have_attributes(rounds: 2)
    end

    it 'generates success message' do
      expect(page).to have_content 'Game was setup successfully'
    end
  end
end
