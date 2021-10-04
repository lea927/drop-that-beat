require 'rails_helper'

RSpec.describe Track, type: :model do
  context 'with transactional examples' do
    it 'has none to begin with' do
      expect(described_class.count).to eq 0
    end

    it 'has one after adding one' do
      create(:track)
      expect(described_class.count).to eq 1
    end
  end

  context 'with transaction example after create' do
    it 'has none after one was created in a previous example' do
      expect(described_class.count).to eq 0
    end
  end

  context 'when instantiated' do
    subject(:track) { build(:track) }

    it { is_expected.to have_attributes(track.attributes) }

    # deliberate failures
    it { is_expected.not_to have_attributes(name: 'New Rules') }
    it { is_expected.not_to have_attributes(artist: 'Lady Gaga') }
    it { is_expected.not_to have_attributes(adam_id: '1551179888') }
    it { is_expected.not_to have_attributes(preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ab/a4/60/aba460c2-787f-7c31-ecbe-b2f50b4e443243/mzaf_12011994877481871015.plus.aac.p.m4a') }
  end

  context 'with valid attributes' do
    subject { build(:track) }

    it { is_expected.to be_valid }
    it { is_expected.to respond_to :rooms }
  end

  context 'when searching stored track' do
    it 'is expected to find track' do
      track = create(:track)
      expect(described_class.search_db(track.adam_id)).to eq track
    end
  end

  context 'when searching unstored track' do
    it 'is expected not to find track' do
      track = build(:track, adam_id: '')
      expect(described_class.search_db(track.adam_id)).to be_nil
    end
  end
end
