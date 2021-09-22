require 'rails_helper'

RSpec.shared_examples 'assigns tracks to rooms and render js' do
  it 'assigns tracks to rooms' do
    expect do
      post tracks_path, params: track.attributes.merge(room_id: room.id), xhr: true
    end.to change(RoomTrack, :count).by(1)
  end

  it 'renders JS' do
    post tracks_path, params: track.attributes.merge(room_id: room.id), xhr: true
    expect(response.media_type).to eq 'text/javascript'
    # expect(response.body).to include track.name
  end
end

RSpec.describe TracksController, type: :request do
  include_context 'when user is logged in'
  let(:room) { create(:room) }
  let(:track) { build(:track) }

  describe 'POST /create' do
    context 'when track is not yet already saved' do
      it 'creates new track' do
        expect do
          post tracks_path, params: track.attributes.merge(room_id: room.id), xhr: true
        end.to change(Track, :count).by(1)
      end

      include_examples 'assigns tracks to rooms and render js'
    end

    context 'when track is already saved' do
      before { track.save }

      it 'does not create track' do
        expect do
          post tracks_path, params: track.attributes.merge(room_id: room.id), xhr: true
        end.not_to change(Track, :count)
      end

      include_examples 'assigns tracks to rooms and render js'
    end
  end

  describe 'DELETE /destroy' do
    before do
      track.save
      room.tracks.push(track)
    end

    it 'destroys the room tracks relation' do
      expect do
        delete track_path(track), params: { room_id: room.id }, xhr: true
      end.to change(RoomTrack, :count).by(-1)
    end

    it 'does not destroy track' do
      delete track_path(track), params: { room_id: room.id }, xhr: true
      expect(track).to be_present
    end

    it 'does not destroy room' do
      delete track_path(track), params: { room_id: room.id }, xhr: true
      expect(room).to be_present
    end
  end
end
