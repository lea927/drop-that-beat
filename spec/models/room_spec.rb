require 'rails_helper'

RSpec.describe Room, type: :model do
  subject(:room) { build(:room, :stub_tracks) }

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to respond_to :tracks }
    it { is_expected.to respond_to :users }
    it { is_expected.to have_attributes(rounds: 1) }

    it 'has 5 tracks' do
      expect(room.tracks.length).to eq 5
    end
  end

  context 'with invalid attributes' do
    it 'is not valid without name' do
      expect(build(:room, name: ' ')).not_to be_valid
    end

    it 'is not valid with blank rounds' do
      expect(build(:room, rounds: ' ')).not_to be_valid
    end

    it 'is not valid with letter rounds' do
      expect(build(:room, rounds: 'ABC')).not_to be_valid
    end

    it 'is not valid with zero or negative rounds' do
      expect(build(:room, rounds: -1)).not_to be_valid
    end

    it 'is not valid with decimal rounds' do
      expect(build(:room, rounds: 1.5)).not_to be_valid
    end

    it 'is not valid with more than 3 rounds' do
      expect(build(:room, rounds: 4)).not_to be_valid
    end

    it 'is not valid with duplicate tracks' do
      room = create(:room)
      existing_track = room.tracks.first
      expect { room.tracks.push(existing_track) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is not valid with less than five tracks' do
      expect(build(:room, tracks: [])).not_to be_valid
    end
  end
end
