require 'rails_helper'

RSpec.describe 'RoomsController', type: :request do
  include_context 'when user is logged in'
  let(:track) { create(:track) }
  let!(:room) { create(:room, tracks: [track]) }

  context 'GET /tracks_json' do
    it 'gets a successful response' do
      get tracks_json_path(room)
      assert_response :success
    end
    it 'gets json from ajax request' do
      get tracks_json_path(room), xhr: true
      assert_equal 'application/json', @response.media_type
    end
    it 'gets 200 ok status' do
      get tracks_json_path(room)
      expect(response).to have_http_status(:ok)
    end
  end
end
