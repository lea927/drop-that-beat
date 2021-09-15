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
  end
end
