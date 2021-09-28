require 'rails_helper'

RSpec.describe 'StartGame', type: :system do
  include_context 'when user is logged in'
  let(:track) { create(:track) }
  let(:track2) { create(:track, name: 'idgaf', adam_id: '1228739604', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/dd/7c/f8/dd7cf8bf-61f2-45e3-9a52-63b7734d5ef1/mzaf_1015632960633637742.plus.aac.p.m4a') }
  let(:track3) { create(:track, artist: 'unordinary sunday, kino & yumin', name: 'UNORDINARY SUNDAY, Vol. 2 - Sunflower', adam_id: '1568415083', preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/67/4c/d7/674cd77b-8931-34a4-1148-7febd8ce042f/mzaf_13159739854727306776.plus.aac.p.m4a') }
  let!(:room) { create(:room, tracks: [track, track2, track3]) }

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

    it 'displays possible answers as buttons with track names', :aggregate_failures do
      click_on 'Start Game'
      expect(page).to have_selector(:link_or_button, track.name).once
      expect(page).to have_selector(:link_or_button, track2.name).once
      expect(page).to have_selector(:link_or_button, track3.name).once
    end
  end
end
