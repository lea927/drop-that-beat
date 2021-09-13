require 'rails_helper'

RSpec.describe 'Creating an Account', type: :system, driver: :selenium_chrome, js: true do

  let(:fillout_form) do
    fill_in 'user_username', with: 'johndoe'
    fill_in 'user_email', with: 'johndoe@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
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
        click_on "Sign up"
        expect(page).to have_content('Welcome! You have signed up successfully.')
        expect(page).to have_current_path(home_page_index_path)
    end
  end

  describe 'Creating an invalid account' do

    it 'fills out form with registered username' do
        create(:user)
        visit new_user_registration_path
        fillout_form
        click_on "Sign up"
        expect(page).to have_content('Username has already been taken')
    end
    it 'fills out form with registered email' do
        create(:user)
        visit new_user_registration_path
        fillout_form
        click_on "Sign up"
        expect(page).to have_content('Email has already been taken')
    end
  end

end