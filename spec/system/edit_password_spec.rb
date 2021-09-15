require 'rails_helper'

RSpec.describe 'Editing an Account', type: :system do
  let(:fillout_form) do
    fill_in 'user_password', with: 'password123'
    fill_in 'user_password_confirmation', with: 'password123'
  end

  before do
    driven_by(:rack_test)
    user = create(:user)
    user.skip_confirmation!
    user.save
    visit root_path
    click_link 'Log In'
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    click_link 'Update Password'
    fillout_form
  end

  # let(:login_user) do
  #   user = create(:user)
  #   user.confirmed_at = Time.current
  #   user.save
  #   visit root_path
  #   click_link 'Log In'
  #   fill_in 'user_email', with: user.email
  #   fill_in 'user_password', with: user.password
  #   click_on 'Log in'
  # end

  it 'can access edit user page' do
    expect(page).to have_current_path(edit_user_registration_path)
  end

  describe 'with valid current password' do
    it 'successfully updates account password' do
      # fillout_form
      fill_in 'user_current_password', with: 'password'
      click_on 'Update'
      expect(page).to have_content('Your account has been updated successfully.')
    end
  end

  describe 'with invalid current password' do
    it 'unsuccessfully updates account password' do
      # fillout_form
      fill_in 'user_current_password', with: 'password098'
      click_on 'Update'
      expect(page).to have_content('Current password is invalid')
    end
  end
end
