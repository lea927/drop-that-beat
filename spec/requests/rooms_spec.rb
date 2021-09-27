require 'rails_helper'

RSpec.describe 'RoomsController', type: :request do
  include_context 'when user is logged in'
  let(:track) { create(:track) }
  let!(:room) { create(:room, tracks: [track]) }

  context 'when GET /tracks_json gets called' do
    it 'gets a successful response' do
      get tracks_json_path(room)
      assert_response :success
    end

    it 'gets json from ajax request' do
      get tracks_json_path(room), xhr: true
      assert_equal 'application/json', response.media_type
    end

    it 'gets 200 ok status' do
      get tracks_json_path(room)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /answer' do
    let(:valid_params) { { user_id: user.id, adam_id: track.adam_id, name: track.name } }
    let(:invalid_params) { { user_id: '456321', adam_id: '456321', name: track.name } }

    context 'with correct answer' do
      it 'user points changes by 1' do
        expect do
          post answer_room_path(room), params: valid_params, xhr: true
        end.to(change { user.reload.points }.by(1))
      end

      it 'returns true' do
        post answer_room_path(room), params: valid_params, xhr: true
        expect(response.body).to eq 'true'
      end

      it 'renders successful response' do
        post answer_room_path(room), params: valid_params, xhr: true
        expect(response).to be_successful
      end
    end

    context 'with incorrect answer' do
      before { track.name = 'IDGAF' }

      it 'user points does not change' do
        expect do
          post answer_room_path(room), params: valid_params, xhr: true
        end.not_to(change { user.reload.points })
      end

      it 'returns false' do
        post answer_room_path(room), params: valid_params, xhr: true
        expect(response.body).to eq 'false'
      end

      it 'renders successful response' do
        post answer_room_path(room), params: valid_params, xhr: true
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'user points does not change' do
        expect do
          post answer_room_path(room), params: invalid_params, xhr: true
        end.not_to(change { user.reload.points })
      end

      it 'renders unsuccessful response' do
        post answer_room_path(room), params: invalid_params, xhr: true
        expect(response).not_to be_successful
      end
    end
  end
end
