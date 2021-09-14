require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context 'with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to respond_to :rooms }
  end

  context 'with invalid attributes' do
    it 'is not valid without email' do
      expect(build(:user, email: '')).not_to be_valid
    end

    it 'is not valid without username' do
      expect(build(:user, username: '')).not_to be_valid
    end

    it 'is not valid with existing email' do
      create(:user)
      expect(build(:user, username: 'janedoe')).not_to be_valid
    end

    it 'is not valid with existing username' do
      create(:user)
      expect(build(:user, email: 'janedoe@example.com')).not_to be_valid
    end
  end
end
