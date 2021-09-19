require 'rails_helper'

RSpec.describe 'CreateGameRooms', type: :system do
  include_context 'when user is logged in'

  before do
    driven_by(:rack_test)
    visit root_path
  end

  def submit_form(room_name)
    fill_in 'Enter room name', with: room_name
    click_on 'Create Room'
  end

  context 'with valid attributes' do
    before { submit_form('animal') }

    it 'creates room' do
      expect(Room.count).to eq 1
    end

    it 'shows game setup details', :aggregate_failures do
      expect(page).to have_content 'Create a Playlist'
      expect(page).to have_content 'Set Rounds'
    end
  end

  context 'with blank room name' do
    it 'generates an error message' do
      submit_form(nil)
      expect(page).to have_content 'Name can\'t be blank'
    end
  end
end
