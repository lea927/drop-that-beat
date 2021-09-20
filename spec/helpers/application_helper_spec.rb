require 'rails_helper'

RSpec.describe ApplicationHelper, :vcr, type: :helper do
  let(:track) { 'dua lipa levitating' }

  describe 'search method' do
    subject { helper.search_track(track) }

    context 'with valid attributes', vcr: 'tracks/dua_lipa' do
      it { is_expected.to be_instance_of(Array) }
    end

    context 'with blank parameters' do
      let(:track) { ' ' }

      it { is_expected.to be_nil }
    end

    context 'with invalid tracks', vcr: 'invalid/tracks/unknown' do
      let(:track) { 'asdfkjhasdflkjhas' }

      it { is_expected.to be_empty }
    end
  end

  describe 'new_tracks', vcr: 'tracks/dua_lipa' do
    subject(:new_tracks) { helper.new_track(tracks) }

    let(:tracks) { helper.search_track(track) }

    context 'with valid attributes' do
      it 'build new track' do
        expect(new_tracks.first).to be_instance_of(Track)
      end

      it 'maps all data' do
        expect(new_tracks.count).to eq(tracks.count)
      end
    end

    context 'with blank parameters' do
      let(:track) { ' ' }

      it { is_expected.to be_nil }
    end

    context 'with invalid tracks', vcr: 'invalid/tracks/unknown' do
      let(:track) { 'asdfkjhasdflkjhas' }

      it { is_expected.to be_nil }
    end
  end
end
