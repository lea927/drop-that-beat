require 'rails_helper'

RSpec.describe Track, type: :model do
  context 'with transactional examples' do
    it 'has none to begin with' do
      expect(described_class.count).to eq 0
    end

    it 'has one after adding one' do
      described_class.create
      expect(described_class.count).to eq 1
    end
  end

  context 'with transaction example after create' do
    it 'has none after one was created in a previous example' do
      expect(described_class.count).to eq 0
    end
  end

  context 'when instantiated' do
    subject { build(:track) }

    it { is_expected.to have_attributes(name: 'Levitating') }
    it { is_expected.to have_attributes(name: a_string_starting_with('L')) }
    it { is_expected.to have_attributes(artist: 'Dua Lipa') }
    it { is_expected.to have_attributes(artist: a_string_starting_with('D')) }
    it { is_expected.to have_attributes(adam_id: 1_551_179_407) }
    it { is_expected.to have_attributes(preview_url: 'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ab/a4/60/aba460c2-787f-7c31-ecbe-b2f50b4e4725/mzaf_12011994877481871015.plus.aac.p.m4a') }
  end
end
