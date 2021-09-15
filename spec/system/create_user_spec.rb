require 'rails_helper'

RSpec.describe 'Creating an Account', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:fillout_form) do
    fill_in 'user_username', with: 'johndoe'
    fill_in 'user_email', with: 'johndoe@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Sign up'
  end

  describe 'Creating a valid account' do
    it 'visits sign up page' do
      visit root_path
      click_link 'Sign Up'
      expect(page).to have_current_path(new_user_registration_path)
    end

    it 'fills out form with valid details' do
      visit new_user_registration_path
      fillout_form
      expect(page).to have_current_path(root_path)
    end
    it 'displays unconfirmed email message' do
      visit new_user_registration_path
      fillout_form
      expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
    end
  end

  describe 'Creating an invalid account' do
    it 'fills out form with registered username' do
      create(:user)
      visit new_user_registration_path
      fillout_form
      expect(page).to have_content('Username has already been taken')
    end

    it 'fills out form with registered email' do
      create(:user)
      visit new_user_registration_path
      fillout_form
      expect(page).to have_content('Email has already been taken')
    end
  end
end
