require 'rails_helper'

RSpec.describe Track, type: :model do
  subject { build(:room)}

  context 'runs transactional examples' do
    it 'has none to begin with' do
      expect(Track.count).to eq 0
    end
  
    it 'has one after adding one' do
      Track.create
      expect(Track.count).to eq 1
    end
  
    it 'has none after one was created in a previous example' do
      expect(Track.count).to eq 0
    end
  end

end
