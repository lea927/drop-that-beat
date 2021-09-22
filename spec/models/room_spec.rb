require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { build(:room) }

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to respond_to :tracks }
    it { is_expected.to respond_to :users }
    it { is_expected.to have_attributes(rounds: 1) }
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

    it 'is not valid with duplicate tracks' do
      track = create(:track)
      room = create(:room, tracks: [track])
      expect { room.tracks.push(track) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
