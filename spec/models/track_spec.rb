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
end
