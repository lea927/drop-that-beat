require 'rails_helper'

RSpec.describe 'SetupGameRooms', type: :system do
  include_context 'when user creates a game room'

  before do
    driven_by(:rack_test)
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

  context 'with rounds less than 1' do
    it 'generates error message' do
      update_rounds(0)
      expect(page).to have_content 'Rounds must be greater than or equal to 1'
    end
  end

  context 'with nil rounds' do
    it 'generates error message' do
      update_rounds(' ')
      expect(page).to have_content 'Rounds can\'t be blank'
    end
  end
end
