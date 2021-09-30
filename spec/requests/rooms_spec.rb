require 'rails_helper'

RSpec.describe 'RoomsController', type: :request do
  include_context 'when user is logged in'
  let(:track) { create(:track) }
  let!(:room) { create(:room, tracks: [track]) }

  describe 'POST /answer' do
    let(:valid_params) { { track_id: track.id, name: track.name, artist: track.artist } }
    let(:invalid_params) { { track_id: '456321', name: track.name, artist: track.artist } }

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
