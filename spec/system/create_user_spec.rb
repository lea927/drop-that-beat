require 'rails_helper'

RSpec.describe 'Create User', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:fillout_form) do
    fill_in 'user[username]', with: 'johndoe'
    fill_in 'user[email]', with: 'johndoe@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'SIGN UP'
  end

  describe 'Creating an account' do
    context 'with valid details' do
      it 'can access sign up page' do
        visit root_path
        click_link 'Sign Up'
        expect(page).to have_current_path(new_user_registration_path)
      end

      it 'cannot access unconfirmed account' do
        visit new_user_registration_path
        fillout_form
        expect(page).to have_current_path(root_path)
      end

      it 'displays unconfirmed email message' do
        visit new_user_registration_path
        fillout_form
        expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
      end
    end

    context 'with invalid details' do
      before do
        create(:user)
        visit new_user_registration_path
        fillout_form
      end

      it 'displays username error message' do
        expect(page).to have_content('Username has already been taken')
      end

      it 'displays email error message' do
        expect(page).to have_content('Email has already been taken')
      end
    end
  end
end
