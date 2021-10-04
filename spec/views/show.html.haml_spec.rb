require 'rails_helper'

RSpec.describe 'rooms/show.html.haml', type: :view do
  include_context 'when user is logged in'
  let!(:room) { create(:room) }

  before do
    assign(:room, room)
    render
  end

  it 'displays the room name' do
    expect(rendered).to include('animal')
  end

  it 'displays start game button' do
    expect(rendered).to have_selector('button', id: 'startGameBtn', text: 'Start Game')
  end

  it 'displays bar' do
    expect(rendered).to have_selector('div', id: 'myBar')
  end

  it 'displays progress' do
    expect(rendered).to have_selector('div', id: 'myProgress')
  end

  # failures
  it 'does not display another loader element', :aggregate_failures do
    expect(rendered).not_to have_selector('div', id: 'theirBar')
    expect(rendered).not_to have_selector('div', id: 'theirProgress')
  end
end
