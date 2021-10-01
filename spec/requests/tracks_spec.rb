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
  end
end

RSpec.describe TracksController, type: :request do
  include_context 'when user is logged in'
  let(:room) { create(:room) }
  let(:track) { build(:track) }

  describe 'GET /show' do
    subject { response }

    before do
      track.save!
      get track_path(track), xhr: true
    end

    it { is_expected.to be_successful }
    it { is_expected.to have_attributes(media_type: 'application/json') }
  end

  describe 'POST /create' do
    before { room }

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

    context 'when track and room is already saved' do
      before do
        track.save
        room.tracks.push(track)
      end

      it 'no change in room tracks table' do
        expect do
          post tracks_path, params: track.attributes.merge(room_id: room.id), xhr: true
        end.not_to change(RoomTrack, :count)
      end
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
