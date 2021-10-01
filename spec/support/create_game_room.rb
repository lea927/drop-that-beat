RSpec.shared_context 'when user creates a game room' do
  include_context 'when user is logged in'
  let(:room) { user.rooms.find_by(name: 'animal') }

  def submit_form(room_name)
    fill_in 'Enter room name', with: room_name
    click_on 'Create Room'
  end

  def update_rounds(rounds)
    select rounds, from: 'Rounds'
    click_on 'Finish setup'
  end

  def search_tracks
    fill_in 'Search track', with: 'dua lipa levitating'
    click_on 'Search'
  end
end
