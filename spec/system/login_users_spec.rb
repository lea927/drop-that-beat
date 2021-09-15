require 'rails_helper'

RSpec.describe 'LoginUsers', type: :system do
  let(:user) { build(:user) }

  before do
    driven_by(:rack_test)
    user.skip_confirmation!
    user.save
    visit root_path
    click_link 'Log In'
  end

  def fillout_form(user)
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  it 'can access login page' do
    expect(page).to have_current_path(new_user_session_path)
  end

  context 'with valid email and password' do
    before { fillout_form(user) }

    it 'can access user account' do
      expect(page).to have_content(user.username)
    end

    it 'display success message' do
      expect(page).to have_content('Signed in successfully.')
    end
  end

  context 'with invalid username' do
    let(:invalid_user) { build(:user, username: 'janedoe') }

    before { fillout_form(invalid_user) }

    it 'cannot access account' do
      expect(page).not_to have_content(user.username)
    end

    it 'display error message' do
      expect(page).to have_content('Invalid Username or password')
    end
  end

  context 'with invalid password' do
    let(:invalid_user) { build(:user, password: 'johndoe') }

    before { fillout_form(invalid_user) }

    it 'cannot access account' do
      expect(page).not_to have_content(user.username)
    end

    it 'display error message' do
      expect(page).to have_content('Invalid Username or password')
    end
  end
end
