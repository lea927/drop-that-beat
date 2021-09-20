RSpec.shared_context 'when user is logged in' do
  let(:user) { build(:user, points: 100) }

  before do
    user.skip_confirmation!
    user.save!
    sign_in user
  end
end
