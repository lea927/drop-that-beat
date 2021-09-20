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
end
